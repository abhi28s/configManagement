## #################################
## Configuration Management using Chef
## #################################

### Keywords
    - DSL - Domain Specific Language
    - DSC - Desired State Configuration
    - Immutable Infrastructure
    - Out-of-Band Changes
    - Imperative (What+How) vs Declarative (What)
    - Chef/Puppet/Ansible/SaltStack/CFEngine/BladeLogic/Powershell DSC

Puppet (Google)
Chef (Facebook) 
Ansible --> Puppet


Jez Humble
Mark Hornbeek
Gene Kim - The Phoenix Project,  The devops handbook, The Goal



### Agenda
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

### Chef Server and Workstation
    Doc - Demo1

### Knife config
    Doc - Demo 3

    Directory structure of Chef-repo for knife
    chef-repo
        --> .chef
            - knife.rb
            - user.pem
            - validator.pem
        --> cookbooks

## ##################################
### Bootstrapping a Chef node

    knife bootstrap <fqdn> -U <username> -N <chefnode> --sudo

    knife bootstrap 46.101.91.42 -U root -N prod-node --sudo

    knife bootstrap 46.101.91.42 -U ubuntu -i ~/.ssh/public_key -N prod-node --sudo

    knife bootstrap 139.59.191.183 -U root -N web-node -r 'role[webserver]' --sudo
## ##################################
### SSH Error
    WARN: [SSH] connection failed, terminating (#<Net::SSH::AuthenticationFailed: Authentication failed for user root@46.101.91.42>)
    ERROR: Train::Transports::SSHFailed: SSH session could not be established

    Solution - edit file /etc/ssh/sshd_config

    PasswordAuthentiation no
    to
    PasswordAuthentication yes

## ##################################
### Knife Command Examples

    knife node list
    knife cookbook list
    knife role list
    knife environment list

### OHAI

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


### Class Activity - 1 (Create a Recipe to install Apache on Ubuntu)
- Apache Web server Installation and configuration
    1. Install apache on Ubuntu
    2. Create a sample index.html file (/var/www/html/index.html)
    3. Start and enable the service

### Class Activity - 2 (Generate Cookbook "web" and upload on Chef server)

    1. Create a cookbook using chef generate command

    chef generate cookbook <cookbookname>

    2. edit the recipe

    vi recipe/default.rb

    ## Install Apache
    package 'apache2' do
        action :install
    end

    ## Start and enable Apache service
    service 'apache2' do
        action [:start, :enable]
    end

    3. upload the cookbook
    knife cookbook upload <cookbookname>

    4. Edit node's runlist

    5. Run "sudo chef-client" on the node

    6. Validate by accessing the web page in a browser

### Class Activity - 3 (Working with Template resource)

    Step 1: Create a template resource

    template '/var/www/html/index.html' do
        source 'index.html.erb'
        variables(
            fqdn: node['fqdn']
        )
        mode '0755'
        action :create
    end

    Step2: Create index.html.erb file

    vi cookbooks/web/templates/index.html.erb

    <html>
        <body>
            <h1>Hello Chef world from <%= @fqdn %> </h1>
        </body>
    </html>

    Step3: upload cookbook

    Step4: sudo chef-client (on node)

    Step5: Validate the changes on browser


## ##################################

### Working with Chef Environments using CLI

    ## List all environments
    knife environment list

    ## Show details of an environment
    knife environment show <environment_name>

    ## Check existing environment of a node

    knife node show <node_name>

    ## Create Environment from file:
    vi ~/chef-repo/environments/prod.rb

    ### No Cookbook restrictions
    name 'prod'
    description 'Our prod environment for business applications'

    ### With Cookbook restrictions
    name 'prod'
    description 'Our prod environment for business applications'

    cookbook 'company_web', '= 0.1.0'
    cookbook 'myhaproxy', '= 1.0.0'
        
    ## Once above file is created, run the following command to create an environment from file:

    knife environment from file prod.rb

    ## Setting node environment to production
    knife node environment set <node_name> <environment_name>

### Class activity - 4 (Working with Chef Environments)

    1. Create a new environment
    2. Add node to the environment
    3. Create a new version of the existing cookbook
    4. Add constraints for cookbooks in the environemnt
    5. Run chef-client
    6. Validate the changes


### Additional Learning (Optional)

    1. Create a parallel lab environment via the following:
        1. Create an account on manage.chef.io
        2. Install chef workstation on your laptop and Configure knife
        3. Bootstrap a node (AWS/DigitalOcean/GCP/Azure)
    
    2. Complete the following track on learn.chef.io
        - Manage your fleet with Chef Infra
    3. Check the tutorials at: https://www.tutorialspoint.com/chef/index.htm
    4. Try to complete Assessment 2 using Chef: 
    "Deployment of WordPress Environment"


Chef Databags --> Encrypted Data bags --> Chef Vault

CFEngine --> C


### References

    https://learn.chef.io/courses/course-v1:chef+Infra101+perpetual/course/
    
