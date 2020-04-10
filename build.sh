echo 'deb http://ftp.nl.debian.org/debian buster-backports contrib non-free main' >> /etc/apt/sources.list
sed 's/^deb /deb-src /' /etc/apt/sources.list >> /etc/apt/sources.list
apt-get --yes update
apt-get --yes install build-essential fakeroot curl linux-source-${KERNEL_VERSION}
apt-get --yes install rsync kmod cpio libssl-dev:native
apt-get --yes build-dep linux
tar --extract --xz --touch --file /usr/src/linux-source-${KERNEL_VERSION}.tar.xz
cd linux-source-${KERNEL_VERSION}
cp ../config-${KERNEL_VERSION} .config
for PATCH in ../patches/*.patch; do patch -p1 < ${PATCH}; done
make oldconfig
make deb-pkg
