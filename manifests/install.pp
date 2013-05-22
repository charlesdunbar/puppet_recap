class puppet_recap::install {

  file { '/tmp/recap.tar.gz':
    ensure => present,
    source => 'puppet:///puppet_recap/recap.tar.gz',
  }

  exec { 'untar_recap':
    creates => "/tmp/recap.tar.gz",
    cwd     => '/tmp',
    path    => ['/bin','/usr/bin','/usr/sbin'],
    command => 'tar -zxf recap.tar.gz',
  }

  exec { 'install_recap':
    creates  => '/usr/sbin/recap',
    cwd      => '/tmp/recap',
    command  => 'bash recap-installer',
    path     => ['/bin','/usr/bin','usr/sbin'],
    requires => Exec['untar_recap'],
  }

}
