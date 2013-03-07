#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_spamdyke
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

remote_file "#{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}.tgz" do
  source "#{node['spamdyke']['source']['url']}/spamdyke-#{node['spamdyke']['version']}.tgz"
  not_if "test -f #{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}.tgz"
end

bash 'unpack-spamdyke' do
  cwd node['spamdyke']['source']['directory']
  code <<-EOH
    pwd
    tar xzf spamdyke-#{node['spamdyke']['version']}.tgz
  EOH
  not_if "test -d #{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}"
end

bash 'compile-spamdyke' do
  cwd "#{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}/spamdyke"
  code <<-EOH
    pwd
    ./configure
    make
  EOH
  not_if "#{node['spamdyke']['bin_dir']}/spamdyke -v 2>&1 | grep -q \'spamdyke #{node['spamdyke']['version']}\'"
end

bash 'install-spamdyke' do
  cwd "#{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}/spamdyke"
  code <<-EOH
    cp spamdyke #{node['spamdyke']['bin_dir']}
  EOH
  not_if "#{node['spamdyke']['bin_dir']}/spamdyke -v 2>&1 | grep -q \'spamdyke #{node['spamdyke']['version']}\'"
end
