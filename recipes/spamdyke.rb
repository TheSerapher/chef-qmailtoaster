#
# Cookbook Name:: qmailtoaster
# Recipe:: spamdyke
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

include_recipe "qmailtoaster"
include_recipe "qmailtoaster::_pre_setup_spamdyke"
include_recipe "qmailtoaster::_install_spamdyke"
include_recipe "qmailtoaster::_configure_spamdyke"
include_recipe "qmailtoaster::_test_spamdyke"

