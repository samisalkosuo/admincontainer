#install tools from git

__current_dir=$(pwd)

#.tmux.git installed in home directory
cd ~
git clone https://github.com/gpakosz/.tmux.git && \
    ln -s .tmux/.tmux.conf 
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
#clone, compile and delete source dir
git clone https://github.com/samisalkosuo/ascii-rain.git
cd ascii-rain
gcc rain-no-c-check.c -o /usr/local/bin/rain -lncurses
cd $__current_dir

