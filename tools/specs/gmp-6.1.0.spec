Name:           gmp
Version:        6.1.0
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        http://mirrors.ustc.edu.cn/gnu/gmp/gmp-6.1.0.tar.bz2
#BuildRequires:  gcc
#Requires:       gcc, automake, autoconf
BuildRoot:      %_topdir/BUILDROOT
Prefix:         /opt/%{name}-%{version}

%description

%prep

%setup -q

%build
./configure \
--prefix=%{prefix}

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
%{prefix}/include/gmp.h
%{prefix}/lib/libgmp.a
%{prefix}/lib/libgmp.la
%{prefix}/lib/libgmp.so
%{prefix}/lib/libgmp.so.10
%{prefix}/lib/libgmp.so.10.3.0
%{prefix}/share/info/dir
%{prefix}/share/info/gmp.info
%{prefix}/share/info/gmp.info-1
%{prefix}/share/info/gmp.info-2
%doc
 
%changelog
