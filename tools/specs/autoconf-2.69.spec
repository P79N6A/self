Name:           autoconf
Version:        2.69
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        http://mirrors.ustc.edu.cn/gnu/autoconf/autoconf-2.69.tar.gz
#BuildRequires:  gcc
#Requires:       gcc, automake, autoconf
BuildRoot:      %_topdir/BUILDROOT
Prefix:         /usr/local

%description

%prep

%setup -q

%build
./configure

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
%{prefix}/bin/autoconf
%{prefix}/bin/autoheader
%{prefix}/bin/autom4te
%{prefix}/bin/autoreconf
%{prefix}/bin/autoscan
%{prefix}/bin/autoupdate
%{prefix}/bin/ifnames
%{prefix}/share/autoconf/Autom4te/C4che.pm
%{prefix}/share/autoconf/Autom4te/ChannelDefs.pm
%{prefix}/share/autoconf/Autom4te/Channels.pm
%{prefix}/share/autoconf/Autom4te/Configure_ac.pm
%{prefix}/share/autoconf/Autom4te/FileUtils.pm
%{prefix}/share/autoconf/Autom4te/General.pm
%{prefix}/share/autoconf/Autom4te/Getopt.pm
%{prefix}/share/autoconf/Autom4te/Request.pm
%{prefix}/share/autoconf/Autom4te/XFile.pm
%{prefix}/share/autoconf/INSTALL
%{prefix}/share/autoconf/autoconf/autoconf.m4
%{prefix}/share/autoconf/autoconf/autoconf.m4f
%{prefix}/share/autoconf/autoconf/autoheader.m4
%{prefix}/share/autoconf/autoconf/autoscan.m4
%{prefix}/share/autoconf/autoconf/autotest.m4
%{prefix}/share/autoconf/autoconf/autoupdate.m4
%{prefix}/share/autoconf/autoconf/c.m4
%{prefix}/share/autoconf/autoconf/erlang.m4
%{prefix}/share/autoconf/autoconf/fortran.m4
%{prefix}/share/autoconf/autoconf/functions.m4
%{prefix}/share/autoconf/autoconf/general.m4
%{prefix}/share/autoconf/autoconf/go.m4
%{prefix}/share/autoconf/autoconf/headers.m4
%{prefix}/share/autoconf/autoconf/lang.m4
%{prefix}/share/autoconf/autoconf/libs.m4
%{prefix}/share/autoconf/autoconf/oldnames.m4
%{prefix}/share/autoconf/autoconf/programs.m4
%{prefix}/share/autoconf/autoconf/specific.m4
%{prefix}/share/autoconf/autoconf/status.m4
%{prefix}/share/autoconf/autoconf/types.m4
%{prefix}/share/autoconf/autom4te.cfg
%{prefix}/share/autoconf/autoscan/autoscan.list
%{prefix}/share/autoconf/autotest/autotest.m4
%{prefix}/share/autoconf/autotest/autotest.m4f
%{prefix}/share/autoconf/autotest/general.m4
%{prefix}/share/autoconf/autotest/specific.m4
%{prefix}/share/autoconf/m4sugar/foreach.m4
%{prefix}/share/autoconf/m4sugar/m4sh.m4
%{prefix}/share/autoconf/m4sugar/m4sh.m4f
%{prefix}/share/autoconf/m4sugar/m4sugar.m4
%{prefix}/share/autoconf/m4sugar/m4sugar.m4f
%{prefix}/share/autoconf/m4sugar/version.m4
%{prefix}/share/info/autoconf.info
%{prefix}/share/info/dir
%{prefix}/share/info/standards.info
%{prefix}/share/man/man1/autoconf.1
%{prefix}/share/man/man1/autoheader.1
%{prefix}/share/man/man1/autom4te.1
%{prefix}/share/man/man1/autoreconf.1
%{prefix}/share/man/man1/autoscan.1
%{prefix}/share/man/man1/autoupdate.1
%{prefix}/share/man/man1/config.guess.1
%{prefix}/share/man/man1/config.sub.1
%{prefix}/share/man/man1/ifnames.1
%doc
 
%changelog
