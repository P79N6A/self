Name:           isl
Version:        0.16.1
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://gcc.gnu.org
Source0:        https://dl.ccavs.org/mirror/gcc/isl-0.16.1.tar.bz2
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
--with-gmp-prefix=/opt/gmp-6.1.0

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
   %{prefix}/include/isl/aff.h
   %{prefix}/include/isl/aff_type.h
   %{prefix}/include/isl/arg.h
   %{prefix}/include/isl/ast.h
   %{prefix}/include/isl/ast_build.h
   %{prefix}/include/isl/ast_type.h
   %{prefix}/include/isl/band.h
   %{prefix}/include/isl/constraint.h
   %{prefix}/include/isl/ctx.h
   %{prefix}/include/isl/deprecated/aff_int.h
   %{prefix}/include/isl/deprecated/ast_int.h
   %{prefix}/include/isl/deprecated/constraint_int.h
   %{prefix}/include/isl/deprecated/ilp_int.h
   %{prefix}/include/isl/deprecated/int.h
   %{prefix}/include/isl/deprecated/map_int.h
   %{prefix}/include/isl/deprecated/mat_int.h
   %{prefix}/include/isl/deprecated/point_int.h
   %{prefix}/include/isl/deprecated/polynomial_int.h
   %{prefix}/include/isl/deprecated/set_int.h
   %{prefix}/include/isl/deprecated/union_map_int.h
   %{prefix}/include/isl/deprecated/val_int.h
   %{prefix}/include/isl/deprecated/vec_int.h
   %{prefix}/include/isl/flow.h
   %{prefix}/include/isl/hash.h
   %{prefix}/include/isl/hmap.h
   %{prefix}/include/isl/id.h
   %{prefix}/include/isl/id_to_ast_expr.h
   %{prefix}/include/isl/id_to_pw_aff.h
   %{prefix}/include/isl/ilp.h
   %{prefix}/include/isl/list.h
   %{prefix}/include/isl/local_space.h
   %{prefix}/include/isl/lp.h
   %{prefix}/include/isl/map.h
   %{prefix}/include/isl/map_to_basic_set.h
   %{prefix}/include/isl/map_type.h
   %{prefix}/include/isl/mat.h
   %{prefix}/include/isl/multi.h
   %{prefix}/include/isl/obj.h
   %{prefix}/include/isl/options.h
   %{prefix}/include/isl/point.h
   %{prefix}/include/isl/polynomial.h
   %{prefix}/include/isl/polynomial_type.h
   %{prefix}/include/isl/printer.h
   %{prefix}/include/isl/schedule.h
   %{prefix}/include/isl/schedule_node.h
   %{prefix}/include/isl/schedule_type.h
   %{prefix}/include/isl/set.h
   %{prefix}/include/isl/set_type.h
   %{prefix}/include/isl/space.h
   %{prefix}/include/isl/stdint.h
   %{prefix}/include/isl/stream.h
   %{prefix}/include/isl/union_map.h
   %{prefix}/include/isl/union_map_type.h
   %{prefix}/include/isl/union_set.h
   %{prefix}/include/isl/union_set_type.h
   %{prefix}/include/isl/val.h
   %{prefix}/include/isl/val_gmp.h
   %{prefix}/include/isl/vec.h
   %{prefix}/include/isl/version.h
   %{prefix}/include/isl/vertices.h
   %{prefix}/lib/libisl.a
   %{prefix}/lib/libisl.la
   %{prefix}/lib/libisl.so
   %{prefix}/lib/libisl.so.15
   %{prefix}/lib/libisl.so.15.1.1
   %{prefix}/lib/libisl.so.15.1.1-gdb.py
   %{prefix}/lib/libisl.so.15.1.1-gdb.pyc
   %{prefix}/lib/libisl.so.15.1.1-gdb.pyo
   %{prefix}/lib/pkgconfig/isl.pc
%doc
 
%changelog
