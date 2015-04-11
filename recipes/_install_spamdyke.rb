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
  notifies :run, 'bash[unpack-spamdyke]', :immediately
end

bash 'unpack-spamdyke' do
  action :nothing
  cwd node['spamdyke']['source']['directory']
  code <<-EOH
    tar xzf spamdyke-#{node['spamdyke']['version']}.tgz
  EOH
  notifies :run, 'bash[compile-spamdyke]', :immediately
end

bash 'compile-spamdyke' do
  action :nothing
  cwd "#{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}"
  code <<-EOH
    cd spamdyke
    ./configure
    make
    cd ../spamdyke-qrv
    ./configure --with-vpopmail-support VALIAS_PATH=/home/vpopmail/bin/valias VUSERINFO_PATH=/home/vpopmail/bin/vuserinfo
    make
  EOH
  notifies :run, 'bash[install-spamdyke]', :immediately
end

bash 'install-spamdyke' do
  action :nothing
  cwd "#{node['spamdyke']['source']['directory']}/spamdyke-#{node['spamdyke']['version']}"
  code <<-EOH
    cp spamdyke/spamdyke #{node['spamdyke']['bin_dir']}
    cp spamdyke-qrv/spamdyke-qrv #{node['spamdyke']['bin_dir']}
  EOH
end
