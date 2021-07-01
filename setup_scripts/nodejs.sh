#install node.js and tools

set -e

#dnf -y module install nodejs:14
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash && source ~/.bashrc

nvm install 14

#install elasticdump
npm install elasticdump -g

#install and configure WeTTY
#https://github.com/butlerx/wetty
#instructions: https://github.com/butlerx/wetty/blob/main/docs/atoz.md

#generate certificate
mkdir -p ~/.ssl
#openssl req -x509 -nodes -days 10950 -newkey ec:<(openssl ecparam -name secp384r1) -subj "/C=FI/ST=None/L=None/O=None/OU=None/CN=None" -out ~/.ssl/wetty.crt -keyout ~/.ssl/wetty.key
openssl req -x509 -nodes -days 10950 -newkey rsa:4096 -subj "/C=FI/ST=None/L=None/O=None/OU=None/CN=WeTTY" -out ~/.ssl/wetty.crt -keyout ~/.ssl/wetty.key
chmod 700 ~/.ssl
chmod 644 ~/.ssl/wetty.crt
chmod 600 ~/.ssl/wetty.key

mkdir -p ~/bin 
source ~/.bash_profile
npm install -g yarn --prefix ~/
yarn global add wetty --prefix ~/

