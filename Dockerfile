#admin docker file
FROM rockylinux/rockylinux:8.4

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#install openssh server in order to generate ssh key
RUN dnf -y install --enablerepo=epel-testing openssh-server
#generate ssh key 
RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
#change ssh key hostname to admincontainer
RUN sed -i s/buildkitsandbox/admincontainer/g /root/.ssh/id_rsa.pub
#set up sshd
RUN ssh-keygen -A && rm -f /run/nologin

#install development tools
RUN dnf -y group install "Development Tools"

#install helpful packages
RUN dnf -y install --enablerepo=epel-testing --enablerepo=powertools \
                    iputils python3 jq nmap httpd-tools curl wget net-tools \
                    git openldap openldap-clients openldap-devel httpd \
                    bind-utils dnsmasq haproxy procps-ng tmux sudo tree \
                    openssl openssl-devel which redhat-indexhtml perl perl-NKF\
                    gpm-libs ncurses* whois telnet ftp ncftp xclip xorg-x11-apps 

#environment variables
ENV OCP_VERSION=4.6.28

#DISPLAY env for Windows set as default
#use -e DISPLAY to set another DISPLAY
#X-server is needed for Windows: https://sourceforge.net/projects/vcxsrv/ 
#and start 'XLaunch' before starting this container
ENV DISPLAY=host.docker.internal:0

#DISPLAY env in Mac
#X-server is needed for Windows: https://www.xquartz.org/
#and start 'XQuartz' before starting this container
#ENV DISPLAY=docker.for.mac.host.internal:0

#DISPLAY env in Linux, use "--net host" when starting the container
#ENV DISPLAY=:0

#install tools, libs, etc
#from /root/setup directory
WORKDIR /root/setup

#copy each .sh file from setup directory
#and execute them
#one at a time so that builds are cached

#install tools from rpms
COPY setup/install_rpms.sh .
RUN sh install_rpms.sh

#install openshift clients
COPY setup/install_openshift_clients.sh .
RUN sh install_openshift_clients.sh

#install node.js and node related tools
COPY setup/install_nodejs.sh .
RUN sh install_nodejs.sh

#install various tools from git sources
COPY setup/install_tools_from_git.sh .
RUN sh install_tools_from_git.sh

#change workdir
WORKDIR /root

#tmux setup
COPY .tmux.conf.local ./
#install tmux plugin packages during build by starting session and killing it
RUN tmux new-session -d -s build && sleep 5 && tmux kill-session -t build

#map this volume to host directory where you want your persistent data
VOLUME ["/root/host"]

COPY environment.sh .
COPY shell.sh .
CMD ["sh","/root/shell.sh"]
