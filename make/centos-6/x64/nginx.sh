yum install libxslt-devel GeoIP-devel -y

nginxver=1.12.2
pcrever=8.41
opensslver=1.0.2l
zlibver=1.2.11

wget "http://nginx.org/download/nginx-${nginxver}.tar.gz"
wget "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${pcrever}.tar.gz"
wget "https://www.openssl.org/source/openssl-${opensslver}.tar.gz"
wget "http://zlib.net/fossils/zlib-${zlibver}.tar.gz"

git clone https://github.com/cuber/ngx_http_google_filter_module
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module
git clone https://github.com/grahamedgecombe/nginx-ct

tar xzvf nginx-${nginxver}.tar.gz
tar xzvf pcre-${pcrever}.tar.gz
tar xzvf openssl-${opensslver}.tar.gz
tar xzvf zlib-${zlibver}.tar.gz

cd nginx-${nginxver}

./configure \
--prefix=/opt/nginx-${nginxver} \
--user=www \
--group=www \
--with-pcre=/root/pcre-${pcrever} \
--with-openssl=/root/openssl-${opensslver} \
--with-zlib=/root/zlib-${zlibver} \
--add-module=/root/nginx-ct \
--add-module=/root/ngx_http_google_filter_module \
--add-module=/root/ngx_http_substitutions_filter_module \
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

make -j4
make install

cp /opt/nginx-${nginxver}/sbin/nginx /usr/local/bin
echo "/opt/nginx-${nginxver}/sbin/nginx" >> /etc/rc.local
