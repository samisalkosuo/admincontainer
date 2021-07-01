#start shell 

source /root/environment.sh

#create required config directories and other directories
mkdir -p /root/host/config/tmux/
mkdir -p /root/tmp

#set environment variables in .bash_profile when starting the container
#so they are accessible when using ssh to connect to container
echo "export OCP_VERSION=$OCP_VERSION" >> /root/.bash_profile
echo "export DISPLAY=$DISPLAY" >> /root/.bash_profile
cat environment.sh | grep -v "^#" >> /root/.bash_profile

#start SSH daemon
__sshd_status=""
if [[ -v DISABLE_SSHD ]]; then
  #DISABLE_SSHD exists, do not start sshd
  __sshd_status="sshd disabled"
else 
  /usr/sbin/sshd
  __sshd_status="sshd started"
fi

#set root password
__rootpassword=$(date +%s | sha256sum | base64 | head -c 15)
if [[ -v ROOT_PASSWORD ]]; then
   #use env variable ROOT_PASSWORD as password
    __rootpassword=$ROOT_PASSWORD
fi 
if [[ -v WRITE_ROOT_PASSWORD_TO_FILE ]]; then
  echo $__rootpassword >  /root/root_pwd.txt
fi
echo "root:$__rootpassword" | chpasswd

__now=$(date)
__hostname=$(hostname)
__predefined_hostname=${ADMIN_CONTAINER_NAME}
if [[ ! "$__hostname" == "${__predefined_hostname}" ]]; then
  __hostname="$__hostname (WARNING: host name should be '${__predefined_hostname}')"
fi
echo "Welcome, friend!"
echo ""
echo "Startup status ($__now):"
echo "  host name: $__hostname"
echo "  $__sshd_status"
if [[ "$__sshd_status" == "sshd started" ]]; then
  echo "  SSH root user pwd: $__rootpassword"
fi
exec /bin/bash -l
