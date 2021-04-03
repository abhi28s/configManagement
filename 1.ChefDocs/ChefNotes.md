## #################################
## Configuration Management using Chef
## #################################

## Keywords
- DSL - Domain Specific Language
- Imperative (What+How) vs Declarative (What)



## ##########################
## Chef Config Management
## ##########################

- Chef server and workstation installation
- Knife Configuration
- Bootstrapping a node
- Writing and running recipes
- Writing Cookbooks
- Talking to Chef server via knife
- Common Resources


- Templates
- Roles and Run-lists
- Environments
- Data bags




# Chef Server and Workstation
    Doc - Demo1

    Knife config

## ##################################
## Bootstrapping a Chef node

    knife bootstrap <fqdn> -U <username> -N <chefnode> --sudo

    knife bootstrap 46.101.91.42 -U root -N prod-node --sudo


## ##################################
## SSH Error
    WARN: [SSH] connection failed, terminating (#<Net::SSH::AuthenticationFailed: Authentication failed for user root@46.101.91.42>)
    ERROR: Train::Transports::SSHFailed: SSH session could not be established

    Solution - edit file /etc/ssh/sshd_config

    PasswordAuthentiation no
    to
    PasswordAuthentication yes


## ##################################
## Knife Command Examples

    knife node list
    knife cookbook list
    knife role list
    knife environment list


## chef OHAI

    CLI - ohai platform
    Recipe - node['platform']

    CLI - ohai memory/total
    Recipe - node['memory']['total']

## ##################################

    package "git" do
        action :install
    end

    ubuntu --> apt-get
    redhat --> yum
    suse --> zypper

## ##################################

    1. Create a cookbook using chef generate command

    chef generate cookbook <cookbookname>

    2. edit the recipe

    vi recipe/default.rb

    ## Install Apache
    package 'apache2' do
        action :install
    end

    ## Start and enable Apache service
    service 'apache2' do
        action [:start, :enable]
    end

    3. upload the cookbook
    knife cookbook upload <cookbookname>

    4. Edit node's runlist

    5. Run "sudo chef-client" on the node

    6. Validate by accessing the web page in a browser



## Assignment (Optional) [3-April-2021]

1. Create an account on manage.chef.io
2. Install chef workstation on your laptop and Configure knife
3. Bootstrap a node (AWS/DigitalOcean/GCP/Azure)

















