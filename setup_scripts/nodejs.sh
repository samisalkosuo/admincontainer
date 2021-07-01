#install node.js and tools

set -e

#dnf -y module install nodejs:14
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash && source ~/.bashrc

nvm install 14

#install elasticdump
npm install elasticdump -g

