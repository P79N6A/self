```bash
## need high level gcc & export CC=...
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive
cd
yum install gettext make asciidoc xmlto c-ares-devel libev-devel -y
export LIBSODIUM_VER=1.0.13
wget https://dl.ccavs.org/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make -j4
make install
popd
ldconfig
export MBEDTLS_VER=2.6.0
wget https://dl.ccavs.org/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
make DESTDIR=/usr install
popd
ldconfig
cd shadowsocks-libev
./autogen.sh && ./configure --prefix=/opt/ss-libev && make -j4
make install && cd
cd /etc/init.d
wget https://raw.githubusercontent.com/max2max/self/master/ssredir
chkconfig ssredir on
chmod +x ssredir
cd /etc/ && wget https://raw.githubusercontent.com/max2max/self/master/ss.json -O ss-redir.json
vim ss-redir.json
```