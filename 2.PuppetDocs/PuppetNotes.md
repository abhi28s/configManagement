## ##############################
### Puppet Notes
## ##############################


## Desired State Configuration


Not Idempotent

 <install desired package>


Idempotent

if
    installed already?
    <dont take any action>

else 
    <install desired package>


Attributes --> Ohai --> Chef-client
Facts --> Facter --> Puppet Agent


Cookbooks --> Recipes ---> Resources (Functions)
Modules ---> Manifests --> Resources (Functions)
Roles ---> Playbooks ----> Modules (Functions)




*.mycompany.com
webserver.mycompany.com
db.mycompany.com

