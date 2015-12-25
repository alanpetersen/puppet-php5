# Class: php5
# ===========================
#
# Full description of class php5 here.
#
# Authors
# -------
#
# Alan Petersen <alan@alanpetersen.net>
#
# Copyright
# ---------
#
# Copyright 2015 Alan Petersen, unless otherwise noted.
#
class php5(
    $targetdir     = $php5::params::targetdir,
    $php_version   = $php5::params::php_version,
) inherits php5::params {

  $configure_cmd = $php5::params::configure_cmd,

  $srcdir = "${targetdir}/php-${php_version}"

  class {'php5::phpdev': }

  class {'php5::rpmforge':
    require => Class['php5::phpdev'],
  }

  class { 'staging':
    path    => '/var/staging',
    require => Class['php5::rpmforge'],
  }

  file { $targetdir:
    ensure => directory,
    before => Staging::Extract['php5.tar.gz'],
  }

  staging::file { 'php5.tar.gz':
    source  => "http://php.net/distributions/php-${php_version}.tar.gz",
    require => Class['staging'],
  }

  staging::extract { 'php5.tar.gz':
    target  => $targetdir,
    creates => "${srcdir}/configure",
    require => Staging::File['php5.tar.gz'],
    notify  => Exec['configure'],
  }

  exec {'configure':
    command     => "${srcdir}/${configure_cmd}",
    path        => '/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    logoutput   => true,
    cwd         => $srcdir,
    refreshonly => true,
    # require   => Staging::Extract['php5.tar.gz'],
    notify      => Exec['make'],
  }

  exec {'make':
    command     => 'make',
    path        => '/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    logoutput   => true,
    cwd         => $srcdir,
    timeout     => 600,
    refreshonly => true,
    notify      => Exec['make_install'],
  }

  exec {'make_install':
    command     => 'make install',
    path        => '/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    logoutput   => true,
    cwd         => $srcdir,
    refreshonly => true,
  }
}
