## #################################
## Configuration Management using Chef
## #################################

### Keywords
- DSL - Domain Specific Language
- Imperative (What+How) vs Declarative (What)


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

    knife bootstrap 46.101.91.42 -U ubuntu -i ~/.ssh/key -N prod-node --sudo

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


### chef OHAI

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


### Class activity - 4 (Update index.html file using Chef)

    1. update the recipe
    ~chef-repo/cookbooks/web/recipes/default.rb

    2. Upload the cookbook
    knife cookbook upload web

    3. Verify the upload on Chef UI
    Check the recipe --> Policy --> web --> content --> recipe

    4. Run Chef client

    sudo chef-client (on the node)


### Class activity - 5 (Working with Chef Environments)

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



### References:

    https://learn.chef.io/courses/course-v1:chef+Infra101+perpetual/course/
