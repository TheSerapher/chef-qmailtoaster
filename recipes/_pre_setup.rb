#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_setup
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

%w{ postfix exim }.each do |pkg|
  package pkg do
    action :remove
    only_if "rpm -qi #{pkg}"
  end
  user pkg do
    action :remove
  end
end

# Install some sort of SMTP so crontab etc. still work
package "ssmtp"

