#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_source_rpm_backend
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Include required recipes

node['qmailtoaster']['packages']['backend']['sources'].each do |data|
  qmailtoaster_rpmbuild data['name'] do
    version data['version']
    arch data['arch']
  end
end

service 'qmail' do
  action [ :enable, :start ]
end
