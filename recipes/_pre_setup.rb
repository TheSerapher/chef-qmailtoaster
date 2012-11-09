#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_setup
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

%w{ postfix exim sendmail }.each do |pkg|
  rpm_package pkg do
    action :remove
    options "--nodeps"
    only_if "rpm -qi #{pkg}"
  end
  user pkg do
    action :remove
  end
end
