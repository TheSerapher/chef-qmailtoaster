#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_configuration
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Include required recipes

node["qmailtoaster"]["packages"]["sources"].each do |data|
  qmailtoaster_rpmbuild data["name"] do
    version data["version"]
    arch data["arch"]
  end
end

service "qmail" do
  action [ :enable, :start ]
end