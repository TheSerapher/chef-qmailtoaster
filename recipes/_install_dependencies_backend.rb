#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_dependencies_backend
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Include required recipes
include_recipe "build-essential"
include_recipe "mysql"
include_recipe "mysql::ruby"
include_recipe "mysql::server"

node["qmailtoaster"]["packages"]["backend"]["required"].each do |pkg|
  package pkg
end
