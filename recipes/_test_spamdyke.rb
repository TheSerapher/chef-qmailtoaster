#
# Cookbook Name:: qmailtoaster
# Recipe:: _test_spamdyke
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute
#

bash 'test-spamdyke' do
  cwd '/tmp'
  code <<-EOH
    export PROTO=TCP
    export TCPLOCALHOST=$(hostname --fqdn)
    export TCPLOCALIP=127.0.0.1
    export TCPLOCALPORT=25025
    #{node['spamdyke']['bin_dir']}/spamdyke \
      --config-file #{node['spamdyke']['conf_link']}/spamdyke.conf \
      --config-test \
      --run-as-user vpopmail:vchkpw \
      /var/qmail/bin/qmail-smtpd \
      /home/vpopmail/bin/vchkpw /bin/true 2>&1
  EOH
end
