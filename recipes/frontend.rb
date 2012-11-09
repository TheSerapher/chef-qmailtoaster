#
# Cookbook Name:: qmailtoaster
# Recipe:: frontend
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

# Include our mail server recipe
include_recipe "qmailtoaster::default"

# Add required repositories
include_recipe "qmailtoaster::_add_repositories"

# Install dependencies
include_recipe "qmailtoaster::_install_dependencies_frontend"

# Install our Source RPMs
include_recipe "qmailtoaster::_install_source_rpm_frontend"