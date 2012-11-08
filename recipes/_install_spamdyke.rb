#
# Cookbook Name:: qmailtoaster
# Recipe:: _install_spamdyke
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{node["spamdyke"]["source"]["directory"]}/spamdyke-#{node["spamdyke"]["version"]}.tgz" do
  source "#{node["spamdyke"]["source"]["url"]}/spamdyke-#{node["spamdyke"]["source"]["version"]}.tgz"
  not_if "test -f #{node["spamdyke"]["source"]["directory"]}/spamdyke-#{node["spamdyke"]["version"]}.tgz"
end

bash "unpack-spamdyke" do
  cwd node["spamdyke"]["source"]["directory"]
  code <<-EOH
    pwd
    tar xzf spamdyke-#{node["spamdyke"]["version"]}.tgz
  EOH
  not_if "test -d #{node["spamdyke"]["source"]["directory"]}/spamdyke-#{node["spamdyke"]["version"]}"
end

bash "compile-spamdyke" do
  cwd "#{node["spamdyke"]["source"]["directory"]}/spamdyke-#{node["spamdyke"]["version"]}/spamdyke"
  code <<-EOH
    pwd
    ./configure
    make
  EOH
  not_if "#{node["spamdyke"]["bin_dir"]}/spamdyke -v 2>&1 | grep -q \"spamdyke #{node["spamdyke"]["version"]}\""
end

bash "install-spamdyke" do
  cwd "#{node["spamdyke"]["source"]["directory"]}/spamdyke-#{node["spamdyke"]["version"]}/spamdyke"
  code <<-EOH
    cp spamdyke #{node["spamdyke"]["bin_dir"]}
  EOH
  not_if "#{node["spamdyke"]["bin_dir"]}/spamdyke -v 2>&1 | grep -q \"spamdyke #{node["spamdyke"]["version"]}\""
end