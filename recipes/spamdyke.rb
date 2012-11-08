#
# Cookbook Name:: qmailtoaster
# Recipe:: spamdyke
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

if node.recipe?('qmailtoaster')
  include_recipe "qmailtoaster::_pre_setup_spamdyke"
  include_recipe "qmailtoaster::_install_spamdyke"
  include_recipe "qmailtoaster::_configure_spamdyke"
  include_recipe "qmailtoaster::_test_spamdyke"
else
  log("Ensure your node includes the qmailtoaster::default recipe.") { level :error }
end

