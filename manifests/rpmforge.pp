class php5::rpmforge {
  exec { 'grab-rpmforge':
    command => '/usr/bin/wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm',
    cwd     => '/tmp',
    creates => '/tmp/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm',
  }

  exec { 'import-key':
    command => '/bin/rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt',
    unless  => '/bin/rpm -qai "*gpg*"|/bin/grep wieers',
    require => Exec['grab-rpmforge'],
  }

  exec { 'install-rpmforge':
    command => '/bin/rpm -i /tmp/rpmforge-release-0.5.2-2.el6.rf.*.rpm',
    unless  => '/bin/rpm -qa | /bin/grep rpmforge-release-0.5.2-2.el6.rf',
    require => Exec['import-key'],
  }

  package { 'libmcrypt-devel':
    ensure  => present,
    require => Exec['install-rpmforge']
  }
}
