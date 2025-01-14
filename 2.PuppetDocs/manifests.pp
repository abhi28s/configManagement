node default {
  package { 'tree':
  ensure => 'present',
  }
  file { '/tmp/info.txt':
    ensure  => 'present',
    content => "This file was created using Puppet",
    mode    => '0644',
    owner   => root,
    group   => root,
  }
  ## user { 'sk12k': ensure => 'present' }

  user { 'sk12k':
    ensure    => 'present',
    password  => 'Passw0rd',
    home      => '/home/sk12k',
    shell     => '/bin/bash',
  }
}

vi /etc/puppetlabs/code/environments/production/manifests/site.pp

node default {
  package { 'install_my_faviourte_pkg':
    name      => 'tree',
    ensure    => 'present',
  }
  file { '/tmp/info.txt':
    ensure    => 'present',
    content   => "This file was created using Puppet on ${::fqdn}\n",
    mode      => '0644',
    owner     => root,
    group     => root,
  }
  user { 'sk12k':
    ensure    => 'present',
    password  => 'Passw0rd',
    home      => '/home/sk12k',
    shell     => '/bin/bash',
  }
}
