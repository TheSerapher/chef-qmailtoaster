#
# Cookbook Name:: qmailtoaster
# Recipe:: _configure_spamdyke
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

# Main configuration
template "#{node["spamdyke"]["conf_dir"]}/spamdyke.conf" do
  source "spamdyke/spamdyke.conf.erb"
  variables(
      "config" => node["spamdyke"]["config"]["main"]
  )
end

# Black- and Whitelist
%w{ blacklist whitelist }.each do |list|
  %w{ ip rdns keywords recipients senders }.each do |type|
    template "#{node["spamdyke"]["conf_dir"]}/#{list}_#{type}" do
      source "spamdyke/list.erb"
      variables(
          "entries" => node["spamdyke"]["config"][list][type]
      )
    end
  end
end

# Deploy new run file to ensure qmail uses spamdyke
template "/var/qmail/supervise/smtp/run" do
  source "spamdyke/run.spamdyke.erb"
  notifies :restart, "service[qmail]"
end