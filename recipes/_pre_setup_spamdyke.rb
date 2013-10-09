#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_setup_spamdyke
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

# Define our qmail service for notifier
service 'qmail' do
  supports [:start, :restart]
  action :nothing
end

# Install dependency
include_recipe 'build-essential'

# Create directories manually prior to compile/install
directory node['spamdyke']['source']['directory']
directory node['spamdyke']['base_dir']
directory node['spamdyke']['bin_dir']
directory node['spamdyke']['conf_dir']
directory node['spamdyke']['var_dir']
directory node['spamdyke']['graylist_dir'] do
  mode '750'
  user node['spamdyke']['vpopmail']['user']
  group node['spamdyke']['vpopmail']['group']
end

# Link directories into FHS
link node['spamdyke']['conf_link'] do
  to node['spamdyke']['conf_dir']
end
link node['spamdyke']['var_link'] do
  to node['spamdyke']['var_dir']
end
