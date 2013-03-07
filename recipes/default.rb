#
# Cookbook Name:: qmailtoaster
# Recipe:: default
#
# Copyright (C) 2013 Sebastian Grewe <sebastian.grewe@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


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
