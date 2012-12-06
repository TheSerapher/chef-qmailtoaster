#
# Cookbook Name:: qmailtoaster
# Recipe:: default
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

# Add required repositories
include_recipe 'qmailtoaster::_add_repositories'

# Remove any existing mailserver but use ssmtp as fallback so cronie is installable
include_recipe 'qmailtoaster::_pre_setup'

# Install dependencies
include_recipe 'qmailtoaster::_install_dependencies_backend'

# Install our Source RPMs
include_recipe 'qmailtoaster::_install_source_rpm_backend'

# Post setup
include_recipe 'qmailtoaster::_post_setup'
