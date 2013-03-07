#
# Cookbook Name:: qmailtoaster
# Recipe:: frontend
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

# Include our mail server recipe
include_recipe 'qmailtoaster::default'

# Add required repositories
include_recipe 'qmailtoaster::_add_repositories'

# Install dependencies
include_recipe 'qmailtoaster::_install_dependencies_frontend'

# Install our Source RPMs
include_recipe 'qmailtoaster::_install_source_rpm_frontend'
