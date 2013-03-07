#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_source_rpm_backend
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

# Include required recipes

# Install packages
node['qmailtoaster']['packages']['backend']['sources'].each do |data|
  # When mrtg is installed exim gets re-installed
  # Remove this again as soon as we are able to
  rpm_package "exim-#{data['name']}" do
    package_name 'exim'
    options '--nodeps'
    action :remove
    only_if { data['name'] == 'qmail-toaster' }
    ignore_failure true
  end
  qmailtoaster_rpmbuild data['name'] do
    version data['version']
    arch data['arch']
  end
end

service 'qmail' do
  action [ :enable, :start ]
end
