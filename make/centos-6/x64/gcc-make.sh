gccver=7.2.0
gmpver=6.1.0
mpfrver=3.1.4
mpcver=1.0.3
islver=0.16.1
export LD_LIBRARY_PATH=/opt/mpc-${mpcver}/lib:/opt/gmp-${gmpver}/lib:/opt/mpfr-${mpfrver}/lib:/opt/isl-${islver}/lib
rm -rf gcc-${gccver}/test
mkdir gcc-${gccver}/test && cd gcc-${gccver}/test
../configure --prefix=/opt/gcc-${gccver} -enable-threads=posix -enable-languages=c,c++ --with-gmp=/opt/gmp-${gmpver} --with-mpfr=/opt/mpfr-${mpfrver} --with-mpc=/opt/mpc-${mpcver} --with-isl=/opt/isl-${islver} -disable-multilib
make -j4 > make.log 2>makeerror.log
make install
cd
