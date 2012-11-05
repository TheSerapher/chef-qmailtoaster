#
# Cookbook Name:: qmailtoaster
# Recipe:: default
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

# Add required repositories
#include_recipe "qmailtoaster::_add_repositories"
#include_recipe "qmailtoaster::_pre_setup"
#include_recipe "qmailtoaster::_install_dependencies"
include_recipe "qmailtoaster::_install_source_rpm"
