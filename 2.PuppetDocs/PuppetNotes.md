## ##############################
### Puppet Notes
## ##############################

### Topics

- Puppet Server Installation
- Puppet Node installation
- Writing simple manifests
- Working locally (puppet apply)
- Managing Nodes (puppet agent run)


Attributes --> Ohai --> Chef-client
Facts --> Facter --> Puppet Agent


Cookbooks --> Recipes ---> Resources (Functions)
Modules ---> Manifests --> Resources (Functions)
Roles ---> Playbooks ----> Modules (Functions)

### ###############################
### Puppet Installation and Configuration
### ###############################

Refer Document PuppetInstallation.txt

**Important Concepts and Configuration Files**

/etc/puppetlabs/puppet/puppet.conf  Main configuration file

/etc/puppetlabs/puppet/ssl  SSL Certificate and other relevant files

/etc/puppetlabs/code  Main folder where all things Puppet are stored on Puppet Server

/etc/puppetlabs/code/environments/production

### ###############################

Within our environment, we have three directories and a couple of files:

- environment.conf: Contains environmental settings; no need to touch this to adjust the production environment out-of-box
- hiera.yaml: Our Hiera configuration file that we'll take a look at this next video!
- data: The directory where we'll store our Hiera data, covered more in the next lesson
- manifests: Where our main manifest(s) are stored, and where we'll take our end-state configurations and map them to which servers we want to use them against
- modules: Directory where we'll write and store our end-state configuration file

### ###############################

All Modules for environment “Production” would be saved inside:

/etc/puppetlabs/code/environments/production/modules/

### ###############################

### Facter and Facts

    Calling facts inside a manifest:
    facts['os']['family']
    or
    $::osfamily


### ###############################
### Configure Local Node using Puppet (puppet Apply)
### ###############################

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

### Validate file syntax

puppet parser validate filename.pp

### Execute file

puppet apply filename.pp


### ###############################
### Configure Local Node using Puppet (puppet Apply)
### ###############################


cd /etc/puppetlabs/code/environments/production/manifests

vi site.pp

Put the following content inside sit.pp

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

### Validate file syntax

puppet parser validate <filename.pp>

### Execute file

Go to puppet nodes and run the following command:

sudo puppet agent -t

### ###############################

### Declare multiple packages in a manifest

    package { 'sudo' : ensure => present }
    package { 'tree' : ensure => present }
    package { 'cron' : ensure => present }

    or

    package {
      [
        'cron',
        'sudo',
        'unzip',
        'tree',
        'screen',
      ]
      ensure => installed,
    }


### ###############################


