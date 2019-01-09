```bash
cat  << "EOF" >> /etc/profile
export mygccver="7.2.0"
export mygmpver="6.1.0"
export mympcver="1.0.3"
export mympfrver="3.1.4"
export myislver="0.16.1"
export LD_LIBRARY_PATH="/opt/gcc-${mygccver}/lib:/opt/gcc-${mygccver}/lib64:/opt/gmp-${mygmpver}/lib:/opt/mpc-${mympcver}/lib:/opt/mpfr-${mympfrver}/lib:/opt/isl-${myislver}/lib"
export PATH="$PATH:/opt/gcc-${mygccver}/bin"
export CC=/opt/gcc-${mygccver}/bin/gcc
export CXX=/opt/gcc-${mygccver}/bin/g++
export CPP=/opt/gcc-${mygccver}/bin/cpp
EOF

mv /usr/bin/gcc /usr/bin/gcc-4.4.7
mv /usr/bin/cpp /usr/bin/cpp-4.4.7

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4.7 99
update-alternatives --install /usr/bin/gcc gcc /opt/gcc-7.2.0/bin/gcc 100

update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-4.4.7 99
update-alternatives --install /usr/bin/cpp cpp /opt/gcc-7.2.0/bin/cpp 100

update-alternatives --config gcc
update-alternatives --config cpp
```