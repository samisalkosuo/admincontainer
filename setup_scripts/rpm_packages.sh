#RPM installs during image build

__rpm_dir=~/rpms
mkdir -p ${__rpm_dir}
#download && install lynx text-based browser

LYNX_PKG=lynx-2.8.9-2.el8.x86_64.rpm
wget -P ${__rpm_dir} http://rpmfind.net/linux/centos/8-stream/PowerTools/x86_64/os/Packages/${LYNX_PKG}
rpm -ivh ${__rpm_dir}/${LYNX_PKG}

#download && install w3m text-based browser
W3M_PKG=w3m-0.5.3-50.git20210102.el8.x86_64.rpm
wget -P ${__rpm_dir} http://rpmfind.net/linux/epel/8/Everything/x86_64/Packages/w/${W3M_PKG}
rpm -ivh ${__rpm_dir}/${W3M_PKG}
