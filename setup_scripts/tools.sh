#install tools from git
set -e
__current_dir=$(pwd)

#.tmux.git installed in home directory
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf 
cd $__current_dir

#install kubeterminal
git clone https://github.com/samisalkosuo/kubeterminal
python3 -m pip install prompt_toolkit
python3 -m pip install pyperclip
cat << EOF > /usr/local/bin/kubeterminal.sh
#!/bin/sh

python3 /root/setup/kubeterminal/kubeterminal.py
EOF
chmod 755 /usr/local/bin/kubeterminal.sh


#install rain, for entertainment
#clone and compile
git clone https://github.com/samisalkosuo/ascii-rain.git
cd ascii-rain
gcc rain-no-c-check.c -o /usr/local/bin/rain -lncurses
cd $__current_dir

#install dumb-init
#https://github.com/Yelp/dumb-init
#dumb-init
#"dumb-init is a simple process supervisor and init system designed to run as PID 1 inside minimal container environments"
python3 -m pip install dumb-init

