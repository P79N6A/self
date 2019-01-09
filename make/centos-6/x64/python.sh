pythonver=3.6.3
pythonurl=https://www.python.org/ftp/python/${pythonver}/Python-${pythonver}.tgz
wget ${pythonurl}
tar -xzvf Python-${pythonver}.tgz python-${pythonver}
cd python-${pythonver}
./configure --enable-optimizations --prefix=/opt/python-${pythonver}
sed -i 's/#zlib zlibmodul/zlib zlibmodul/g' Modules/Setup
sed -i '209,212s/#//g' Modules/Setup
make
make test
make install
