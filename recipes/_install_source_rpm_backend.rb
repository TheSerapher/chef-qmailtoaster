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

# Install packages from source
node['qmailtoaster']['packages']['backend']['sources'].each do |pkg|
  qmailtoaster_rpmbuild pkg['name'] do
    version pkg['version']
    arch pkg['arch']
    checksum pkg['checksum']
  end
end

service 'qmail' do
  action [:enable]
end
