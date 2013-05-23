class puppet_recap::install {

  $prereqs = ['sysstat', 'coreutils', 'procps', 'grep', 'gawk'],
  package { $prereqs: ensure => "installed", }

  file { '/tmp/recap.tar.gz':
    ensure  => present,
    source  => 'puppet:///modules/puppet_recap/recap.tar.gz',
    require => Package['sysstat'],
  }

  exec { 'untar_recap':
    cwd     => '/tmp',
    path    => ['/bin','/usr/bin','/usr/sbin'],
    command => 'tar -zxf recap.tar.gz',
    require => File['/tmp/recap.tar.gz'],
    creates => "/var/log/recap",
  }

  exec { 'install_recap':
    creates  => '/usr/sbin/recap',
    cwd      => '/tmp/recap',
    command  => 'bash recap-installer',
    path     => ['/bin','/usr/bin','usr/sbin'],
    require => Exec['untar_recap'],
  }

}
