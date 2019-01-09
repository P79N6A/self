Name:           nginx
Version:        1.12.1
Release:        1%{?dist}
Summary:        Test
Group:          Test
License:        No
URL:            http://nginx.org
Source0:        http://nginx.org/download/%{name}-%{version}.tar.gz
#BuildRequires:  gcc, automake
#Requires:       gcc
BuildRoot:      %_topdir/BUILDROOT
Prefix:         /opt/%{name}-%{version}

%description

%prep
%setup -q
tar -xzvf %_topdir/SOURCES/pcre-8.41.tar.gz -C %_topdir/BUILD/
tar -xzvf %_topdir/SOURCES/openssl-1.0.2l.tar.gz -C %_topdir/BUILD/
tar -xzvf %_topdir/SOURCES/zlib-1.2.11.tar.gz -C %_topdir/BUILD/

%build
./configure \
--prefix=%{prefix} \
--user=www \
--group=www \
--with-pcre=%_topdir/BUILD/pcre-8.41 \
--with-openssl=%_topdir/BUILD/openssl-1.0.2l \
--with-zlib=%_topdir/BUILD/zlib-1.2.11 \
--add-module=%_topdir/SOURCES/nginx-ct \
--add-module=%_topdir/SOURCES/ngx_http_google_filter_module \
--add-module=%_topdir/SOURCES/ngx_http_substitutions_filter_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_flv_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-http_dav_module \
--with-http_realip_module \
--with-http_mp4_module \
--with-http_geoip_module \
--with-http_secure_link_module \
--with-http_random_index_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_ssl_module \
--with-debug \
--with-pcre-jit \
--with-http_xslt_module

make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
%{prefix}/conf/fastcgi.conf
%{prefix}/conf/fastcgi.conf.default
%{prefix}/conf/fastcgi_params
%{prefix}/conf/fastcgi_params.default
%{prefix}/conf/koi-utf
%{prefix}/conf/koi-win
%{prefix}/conf/mime.types
%{prefix}/conf/mime.types.default
%{prefix}/conf/nginx.conf
%{prefix}/conf/nginx.conf.default
%{prefix}/conf/scgi_params
%{prefix}/conf/scgi_params.default
%{prefix}/conf/uwsgi_params
%{prefix}/conf/uwsgi_params.default
%{prefix}/conf/win-utf
%{prefix}/html/50x.html
%{prefix}/html/index.html
%{prefix}/sbin/nginx

%doc

%changelog
