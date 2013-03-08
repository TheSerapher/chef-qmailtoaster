#
# Cookbook Name:: qmailtoaster
# Recipe:: _configure_qmail
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

# Deploy new run file to ensure qmail has enough memory
template '/var/qmail/supervise/submission/run' do
  source 'submission/run.erb'
  user 'qmaill'
  group 'qmail'
  mode '751'
  notifies :restart, 'service[qmail]'
end
