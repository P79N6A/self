Name:           mpc
Version:        1.0.3
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        http://mirrors.ustc.edu.cn/gnu/mpc/mpc-1.0.3.tar.gz
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
--with-gmp=/opt/gmp-6.1.0 \
--with-mpfr=/opt/mpfr-3.1.4

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
   %{prefix}/include/mpc.h
   %{prefix}/lib/libmpc.a
   %{prefix}/lib/libmpc.la
   %{prefix}/lib/libmpc.so
   %{prefix}/lib/libmpc.so.3
   %{prefix}/lib/libmpc.so.3.0.0
   %{prefix}/share/info/dir
   %{prefix}/share/info/mpc.info
%doc
 
%changelog
