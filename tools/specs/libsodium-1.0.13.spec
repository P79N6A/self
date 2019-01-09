Name:           libsodium
Version:        1.0.13
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        libsodium-1.0.13.tar.gz
#BuildRequires:  gcc
#Requires:       gcc, automake, autoconf
BuildRoot:      %_topdir/BUILDROOT
#Prefix:         /opt/%{name}-%{version}
Prefix:         /usr

%description

%prep

%setup -q

%build
./configure

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files

%doc
 
%changelog
