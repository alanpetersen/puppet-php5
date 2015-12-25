class php5::phpdev {
  $packages = [
    'libxml2-devel', 'libXpm-devel', 'gmp-devel', 'libicu-devel', 't1lib-devel', 'aspell-devel',
    'openssl-devel', 'libcurl-devel', 'libjpeg-turbo-devel', 'libvpx-devel', 'libpng-devel',
    'freetype-devel', 'readline-devel', 'libtidy-devel', 'libxslt-devel', 'bzip2-devel', 'gcc-c++'
  ]

  package { $packages:
    ensure => present,
  }

}
