yum install ncurses-devel -y
git clone https://github.com/rolandriegel/nload
cd nload
./run_autotools
./configure
make
make install
cd
