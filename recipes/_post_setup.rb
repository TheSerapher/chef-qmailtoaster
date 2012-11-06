#
# Cookbook Name:: qmailtoaster
# Recipe:: _post_setup
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

# Now that everything is installed we do some last minute changes
template "/home/vpopmail/etc/vpopmail.mysql" do
  source "vpopmail/vpopmail.mysql.erb"
end