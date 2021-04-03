## Install Apache
package 'apache2' do
    action :install
end

## Start and enable Apache service
service 'apache2' do
    action [:start, :enable]
end


