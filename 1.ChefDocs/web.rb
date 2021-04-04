## Install Apache
package 'apache2' do
    action :install
end

## Start and enable Apache service
service 'apache2' do
    action [:start, :enable]
end

## Create index file
file '/var/www/html/index.html' do
    content '<html>
        <body>
            <h1>Hello Chef world</h1>
        </body>
    </html>'
end

## Create a template resource

template '/var/www/html/index.html' do
    source 'index.html.erb'
    variables(
        fqdn: node['fqdn']
    )
    mode '0755'
    action :create
end








