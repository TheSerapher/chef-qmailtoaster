#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_configuration
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

%{ postfix exim }.each do |pkg|
  package pkg do
    action :remove
  end
  user pkg do
    action :remove
  end
end

