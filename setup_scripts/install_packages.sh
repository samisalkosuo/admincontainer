#install packages from repo
#add packages to be installed from repo here

dnf -y install --enablerepo=epel-testing --enablerepo=powertools \
                    iputils \
                    python3 \
                    jq \
                    nmap \
                    httpd-tools \
                    curl \
                    wget \
                    net-tools \
                    git \
                    openldap \
                    openldap-clients \
                    openldap-devel \
                    httpd \
                    bind-utils \
                    dnsmasq \
                    haproxy \
                    procps-ng \
                    tmux \
                    sudo \
                    tree \
                    openssl \
                    openssl-devel \
                    which \
                    redhat-indexhtml \
                    perl \
                    perl-NKF \
                    gpm-libs \
                    ncurses* \
                    whois \
                    telnet \
                    ftp \
                    ncftp \
                    xclip \
                    xorg-x11-apps \
                    vim 

