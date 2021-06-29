#RPM installs during image build

#download && install lynx text-based browser
LYNX_PKG=lynx-2.8.9-2.el8.x86_64.rpm
wget -P /tmp http://rpmfind.net/linux/centos/8-stream/PowerTools/x86_64/os/Packages/${LYNX_PKG}
rpm -ivh /tmp/${LYNX_PKG}
rm -rf /tmp/${LYNX_PKG}

#download && install w3m text-based browser
W3M_PKG=w3m-0.5.3-50.git20210102.el8.x86_64.rpm
wget wget -P /tmp http://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/w/${W3M_PKG}
rpm -ivh /tmp/${W3M_PKG}
rm -rf ${W3M_PKG}
