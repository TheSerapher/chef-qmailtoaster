#
# Cookbook Name:: qmailtoaster
# Recipe:: _configure_database
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless["qmailtoaster"]["vpopmail"]["database"]["password"] = secure_password

# Setup vpopmail account so the database can be created during RPM installation
mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

mysql_database 'vpopmail' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'vpopmail' do
  connection mysql_connection_info
  password node["qmailtoaster"]["vpopmail"]["database"]["password"]
  database_name 'vpopmail'
  privileges [:all]
  action :grant
end

mysql_database "flush the privileges" do
  connection mysql_connection_info
  sql "flush privileges"
  action :query
end