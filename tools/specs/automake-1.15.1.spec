Name:           automake
Version:        1.15.1
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        http://mirrors.ustc.edu.cn/gnu/automake/automake-1.15.1.tar.gz
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
%{prefix}bin/aclocal
%{prefix}bin/automake
%{prefix}bin/automake-1.15
%{prefix}share/aclocal-1.15/amversion.m4
%{prefix}share/aclocal-1.15/ar-lib.m4
%{prefix}share/aclocal-1.15/as.m4
%{prefix}share/aclocal-1.15/auxdir.m4
%{prefix}share/aclocal-1.15/cond-if.m4
%{prefix}share/aclocal-1.15/cond.m4
%{prefix}share/aclocal-1.15/depend.m4
%{prefix}share/aclocal-1.15/depout.m4
%{prefix}share/aclocal-1.15/dmalloc.m4
%{prefix}share/aclocal-1.15/extra-recurs.m4
%{prefix}share/aclocal-1.15/gcj.m4
%{prefix}share/aclocal-1.15/init.m4
%{prefix}share/aclocal-1.15/install-sh.m4
%{prefix}share/aclocal-1.15/internal/ac-config-macro-dirs.m4
%{prefix}share/aclocal-1.15/lead-dot.m4
%{prefix}share/aclocal-1.15/lex.m4
%{prefix}share/aclocal-1.15/lispdir.m4
%{prefix}share/aclocal-1.15/maintainer.m4
%{prefix}share/aclocal-1.15/make.m4
%{prefix}share/aclocal-1.15/missing.m4
%{prefix}share/aclocal-1.15/mkdirp.m4
%{prefix}share/aclocal-1.15/obsolete.m4
%{prefix}share/aclocal-1.15/options.m4
%{prefix}share/aclocal-1.15/prog-cc-c-o.m4
%{prefix}share/aclocal-1.15/python.m4
%{prefix}share/aclocal-1.15/runlog.m4
%{prefix}share/aclocal-1.15/sanity.m4
%{prefix}share/aclocal-1.15/silent.m4
%{prefix}share/aclocal-1.15/strip.m4
%{prefix}share/aclocal-1.15/substnot.m4
%{prefix}share/aclocal-1.15/tar.m4
%{prefix}share/aclocal-1.15/upc.m4
%{prefix}share/aclocal-1.15/vala.m4
%{prefix}share/aclocal/README
%{prefix}share/automake-1.15/Automake/ChannelDefs.pm
%{prefix}share/automake-1.15/Automake/Channels.pm
%{prefix}share/automake-1.15/Automake/Condition.pm
%{prefix}share/automake-1.15/Automake/Config.pm
%{prefix}share/automake-1.15/Automake/Configure_ac.pm
%{prefix}share/automake-1.15/Automake/DisjConditions.pm
%{prefix}share/automake-1.15/Automake/FileUtils.pm
%{prefix}share/automake-1.15/Automake/General.pm
%{prefix}share/automake-1.15/Automake/Getopt.pm
%{prefix}share/automake-1.15/Automake/Item.pm
%{prefix}share/automake-1.15/Automake/ItemDef.pm
%{prefix}share/automake-1.15/Automake/Language.pm
%{prefix}share/automake-1.15/Automake/Location.pm
%{prefix}share/automake-1.15/Automake/Options.pm
%{prefix}share/automake-1.15/Automake/Rule.pm
%{prefix}share/automake-1.15/Automake/RuleDef.pm
%{prefix}share/automake-1.15/Automake/VarDef.pm
%{prefix}share/automake-1.15/Automake/Variable.pm
%{prefix}share/automake-1.15/Automake/Version.pm
%{prefix}share/automake-1.15/Automake/Wrap.pm
%{prefix}share/automake-1.15/Automake/XFile.pm
%{prefix}share/automake-1.15/COPYING
%{prefix}share/automake-1.15/INSTALL
%{prefix}share/automake-1.15/am/check.am
%{prefix}share/automake-1.15/am/check2.am
%{prefix}share/automake-1.15/am/clean-hdr.am
%{prefix}share/automake-1.15/am/clean.am
%{prefix}share/automake-1.15/am/compile.am
%{prefix}share/automake-1.15/am/configure.am
%{prefix}share/automake-1.15/am/data.am
%{prefix}share/automake-1.15/am/dejagnu.am
%{prefix}share/automake-1.15/am/depend.am
%{prefix}share/automake-1.15/am/depend2.am
%{prefix}share/automake-1.15/am/distdir.am
%{prefix}share/automake-1.15/am/footer.am
%{prefix}share/automake-1.15/am/header-vars.am
%{prefix}share/automake-1.15/am/header.am
%{prefix}share/automake-1.15/am/inst-vars.am
%{prefix}share/automake-1.15/am/install.am
%{prefix}share/automake-1.15/am/java.am
%{prefix}share/automake-1.15/am/lang-compile.am
%{prefix}share/automake-1.15/am/lex.am
%{prefix}share/automake-1.15/am/library.am
%{prefix}share/automake-1.15/am/libs.am
%{prefix}share/automake-1.15/am/libtool.am
%{prefix}share/automake-1.15/am/lisp.am
%{prefix}share/automake-1.15/am/ltlib.am
%{prefix}share/automake-1.15/am/ltlibrary.am
%{prefix}share/automake-1.15/am/mans-vars.am
%{prefix}share/automake-1.15/am/mans.am
%{prefix}share/automake-1.15/am/program.am
%{prefix}share/automake-1.15/am/progs.am
%{prefix}share/automake-1.15/am/python.am
%{prefix}share/automake-1.15/am/remake-hdr.am
%{prefix}share/automake-1.15/am/scripts.am
%{prefix}share/automake-1.15/am/subdirs.am
%{prefix}share/automake-1.15/am/tags.am
%{prefix}share/automake-1.15/am/texi-vers.am
%{prefix}share/automake-1.15/am/texibuild.am
%{prefix}share/automake-1.15/am/texinfos.am
%{prefix}share/automake-1.15/am/vala.am
%{prefix}share/automake-1.15/am/yacc.am
%{prefix}share/automake-1.15/ar-lib
%{prefix}share/automake-1.15/compile
%{prefix}share/automake-1.15/config.guess
%{prefix}share/automake-1.15/config.sub
%{prefix}share/automake-1.15/depcomp
%{prefix}share/automake-1.15/install-sh
%{prefix}share/automake-1.15/mdate-sh
%{prefix}share/automake-1.15/missing
%{prefix}share/automake-1.15/mkinstalldirs
%{prefix}share/automake-1.15/py-compile
%{prefix}share/automake-1.15/tap-driver.sh
%{prefix}share/automake-1.15/test-driver
%{prefix}share/automake-1.15/texinfo.tex
%{prefix}share/automake-1.15/ylwrap
%{prefix}share/doc/automake/amhello-1.0.tar.gz
%{prefix}share/info/automake-history.info
%{prefix}share/info/automake.info
%{prefix}share/info/automake.info-1
%{prefix}share/info/automake.info-2
%{prefix}share/info/dir
%{prefix}share/man/man1/aclocal-1.15.1
%{prefix}share/man/man1/aclocal.1
%{prefix}share/man/man1/automake-1.15.1
%{prefix}share/man/man1/automake.1
%doc
 
%changelog
