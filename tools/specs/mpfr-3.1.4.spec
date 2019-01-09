Name:           mpfr
Version:        3.1.4
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        http://mirrors.ustc.edu.cn/gnu/mpfr/mpfr-3.1.4.tar.bz2
#BuildRequires:  gcc
#Requires:       gcc, automake, autoconf
BuildRoot:      %_topdir/BUILDROOT
Prefix:         /opt/%{name}-%{version}

%description

%prep

%setup -q
%build
./configure \
--prefix=%{prefix} \
--with-gmp=/opt/gmp-6.1.0

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
   %{prefix}/include/mpf2mpfr.h
   %{prefix}/include/mpfr.h
   %{prefix}/lib/libmpfr.a
   %{prefix}/lib/libmpfr.la
   %{prefix}/lib/libmpfr.so
   %{prefix}/lib/libmpfr.so.4
   %{prefix}/lib/libmpfr.so.4.1.4
   %{prefix}/share/doc/mpfr/AUTHORS
   %{prefix}/share/doc/mpfr/BUGS
   %{prefix}/share/doc/mpfr/COPYING
   %{prefix}/share/doc/mpfr/COPYING.LESSER
   %{prefix}/share/doc/mpfr/FAQ.html
   %{prefix}/share/doc/mpfr/NEWS
   %{prefix}/share/doc/mpfr/TODO
   %{prefix}/share/doc/mpfr/examples/ReadMe
   %{prefix}/share/doc/mpfr/examples/divworst.c
   %{prefix}/share/doc/mpfr/examples/rndo-add.c
   %{prefix}/share/doc/mpfr/examples/sample.c
   %{prefix}/share/doc/mpfr/examples/version.c
   %{prefix}/share/info/dir
   %{prefix}/share/info/mpfr.info
%doc
 
%changelog
