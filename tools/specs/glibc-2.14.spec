Name:           glibc
Version:        2.14
Release:        %{version}%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://ftp.gnu.org
Source0:        glibc-2.14.tar.gz
#BuildRequires:  gcc
#Requires:       gcc, automake, autoconf
BuildRoot:      %_topdir/BUILDROOT
Prefix:         /opt/%{name}-%{version}

%description

%prep

%setup -q

%build
mkdir %_topdir/BUILD/%{name}-%{version}/test
cd %_topdir/BUILD/%{name}-%{version}/test
../configure \
--prefix=%{prefix}

make %{?_smp_mflags}

%install
cd %_topdir/BUILD/%{name}-%{version}/test
make install DESTDIR=%{buildroot}

%files
 
%doc
 
%changelog
