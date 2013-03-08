#
# Cookbook Name:: qmailtoaster
# Recipe:: _configure_spamdyke
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

# Define our resource
service 'qmail' do
  action :nothing
end

# Main configuration
template "#{node['spamdyke']['conf_dir']}/spamdyke.conf" do
  source 'spamdyke/spamdyke.conf.erb'
  user node['spamdyke']['vpopmail']['user']
  group node['spamdyke']['vpopmail']['group']
  variables(
      'config' => node['spamdyke']['config']['main']
  )
end

# Black- and Whitelist
%w{ blacklist whitelist }.each do |list|
  %w{ ip rdns keywords recipients senders }.each do |type|
    template "#{node['spamdyke']['conf_dir']}/#{list}_#{type}" do
      user node['spamdyke']['vpopmail']['user']
      group node['spamdyke']['vpopmail']['group']
      source 'spamdyke/list.erb'
      variables(
          'entries' => node['spamdyke']['config'][list][type]
      )
    end
  end
end

# Deploy new run file to ensure qmail uses spamdyke
template '/var/qmail/supervise/smtp/run' do
  source 'spamdyke/run.spamdyke.erb'
  user node['spamdyke']['qmail']['user']
  group node['spamdyke']['qmail']['group']
  mode '751'
  notifies :restart, 'service[qmail]'
end
