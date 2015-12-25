class php5::params {

  # CHECK OS TO ENSURE SUPPORT
  if($::osfamily != 'redhat') {
    fail("${::osfamily} is not a supported operating system.")
  }

  if($::operatingsystemmajrelease != '6') {
    fail("${::operatingsystemmajrelease} is not a supported OS release.")
  }

  $targetdir     = '/tmp/src'
  $php_version   = '5.5.30'

  if versioncmp($::phpversion, $php_version) >= 0 {
    fail("${::phpversion} is already installed on this system")
  }

  $configure_cmd = 'configure \
    --with-libdir=lib64 \
    --prefix=/usr/local \
    --with-layout=PHP \
    --with-pear \
    --enable-calendar \
    --enable-bcmath \
    --with-gmp \
    --enable-exif \
    --with-mcrypt \
    --with-mhash \
    --with-zlib \
    --with-bz2 \
    --enable-zip \
    --enable-ftp \
    --enable-mbstring \
    --with-iconv \
    --enable-intl \
    --with-icu-dir=/usr \
    --with-gettext \
    --with-pspell \
    --enable-sockets \
    --with-openssl \
    --with-curl \
    --with-curlwrappers \
    --with-gd \
    --enable-gd-native-ttf \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-vpx-dir=/usr \
    --with-freetype-dir=/usr \
    --with-t1lib=/usr \
    --with-libxml-dir=/usr \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --enable-soap \
    --with-xmlrpc \
    --with-xsl \
    --with-tidy=/usr \
    --with-readline \
    --enable-pcntl \
    --enable-sysvshm \
    --enable-sysvmsg \
    --enable-shmop'
}
