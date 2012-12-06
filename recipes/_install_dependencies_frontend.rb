#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_dependencies_frontend
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Include required recipes
include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'php'
include_recipe 'php::module_mysql'
include_recipe 'php::module_ldap'

node['qmailtoaster']['packages']['frontend']['required'].each do |pkg|
  package pkg
end
