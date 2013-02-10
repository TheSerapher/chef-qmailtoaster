#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_source_rpm_backend
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Include required recipes

node['qmailtoaster']['packages']['backend']['sources'].each do |data|
  # When mrtg is installed exim gets re-installed
  # Remove this again as soon as we are able to
  if data['name'] == 'qmail-toaster'
    rpm_package 'exim' do
      options '--no-deps'
      action :remove
    end
  end
  qmailtoaster_rpmbuild data['name'] do
    version data['version']
    arch data['arch']
  end
end

service 'qmail' do
  action [ :enable, :start ]
end
