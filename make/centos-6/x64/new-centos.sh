yum install ntpdate -y
ntpdate ntp.sjtu.edu.cn
yum install epel-release -y
yum update -y
yum upgrade -y
yum install xz telnet bind-utils vim wget git gcc gcc-c++ bison texinfo kernel-devel ncurses-devel pcre-devel unzip -y
wget http://mirrors.ustc.edu.cn/gnu/libtool/libtool-2.4.6.tar.gz
tar -xzvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
./configure && make -j4 && make install && cd ../
wget http://mirrors.ustc.edu.cn/gnu/autoconf/autoconf-2.69.tar.gz
tar -xzvf autoconf-2.69.tar.gz
cd autoconf-2.69
./configure && make -j4 && make install && cd ../
wget http://mirrors.ustc.edu.cn/gnu/automake/automake-1.15.1.tar.gz
tar -xzvf automake-1.15.1.tar.gz
cd automake-1.15.1
./configure && make -j4 && make install && cd ../
wget http://mirrors.ustc.edu.cn/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.gz
wget http://mirrors.ustc.edu.cn/gnu/gmp/gmp-6.1.0.tar.bz2
wget http://mirrors.ustc.edu.cn/gnu/mpfr/mpfr-3.1.4.tar.bz2
wget http://mirrors.ustc.edu.cn/gnu/mpc/mpc-1.0.3.tar.gz
wget https://dl.ccavs.org/mirror/gcc/isl-0.16.1.tar.bz2
tar -xzvf gcc-7.2.0.tar.gz
tar -xjvf gmp-6.1.0.tar.bz2
tar -xjvf mpfr-3.1.4.tar.bz2
tar -xzvf mpc-1.0.3.tar.gz
tar -xjvf isl-0.16.1.tar.bz2
cd /root/gmp-6.1.0
./configure --prefix=/opt/gmp-6.1.0
make -j4 && make install && cd /root/mpfr-3.1.4
./configure --prefix=/opt/mpfr-3.1.4 --with-gmp=/opt/gmp-6.1.0
make -j4 && make install && cd /root/mpc-1.0.3
./configure --prefix=/opt/mpc-1.0.3 --with-gmp=/opt/gmp-6.1.0 --with-mpfr=/opt/mpfr-3.1.4
make -j4 && make install && cd /root/isl-0.16.1
./configure --prefix=/opt/isl-0.16.1 --with-gmp-prefix=/opt/gmp-6.1.0
make -j4 && make install && cd
export LD_LIBRARY_PATH=/opt/mpc-1.0.3/lib:/opt/gmp-6.1.0/lib:/opt/mpfr-3.1.4/lib:/opt/isl-0.16.1/lib
rm -rf gcc-7.2.0/test
mkdir gcc-7.2.0/test && cd gcc-7.2.0/test
../configure --prefix=/opt/gcc-7.2.0 -enable-threads=posix -enable-languages=c,c++ --with-gmp=/opt/gmp-6.1.0 --with-mpfr=/opt/mpfr-3.1.4 --with-mpc=/opt/mpc-1.0.3 --with-isl=/opt/isl-0.16.1 -disable-multilib
make -j4 > make.log 2>makeerror.log
make install && cd
