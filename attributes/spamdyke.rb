# Spamdyke options to compile and install
default['spamdyke']['version'] = '4.3.1'
default['spamdyke']['source']['url'] = 'http://www.spamdyke.org/releases'
default['spamdyke']['source']['directory'] = '/usr/src/spamdyke'
default['spamdyke']['base_dir'] = '/opt/spamdyke'
default['spamdyke']['conf_link'] = '/etc/spamdyke'
default['spamdyke']['var_link'] = '/var/spamdyke'
default['spamdyke']['conf_dir'] = node['spamdyke']['base_dir'] + '/etc'
default['spamdyke']['bin_dir'] = node['spamdyke']['base_dir'] + '/bin'
default['spamdyke']['var_dir'] = node['spamdyke']['base_dir'] + '/var'
default['spamdyke']['graylist_dir'] = node['spamdyke']['var_dir'] + '/graylist'
default['spamdyke']['conf_file'] = node['spamdyke']['conf_dir'] + '/spamdyke.conf'
default['spamdyke']['qmail']['supervise'] = '/var/qmail/supervise'
default['spamdyke']['qmail']['control'] = '/var/qmail/control'
default['spamdyke']['rcphost']['files'] = %w('rcpthosts', 'morercpthosts')

# Runtime options
default['spamdyke']['vpopmail']['user'] = 'vpopmail'
default['spamdyke']['vpopmail']['group'] = 'vchkpw'
default['spamdyke']['qmail']['user'] = 'qmaill'
default['spamdyke']['qmail']['group'] = 'qmail'

# Spamdyke main configuration options
default['spamdyke']['config']['main'] = {
    'dns-blacklist-entry' => [ 'zen.spamhaus.org', 'bl.spamcop.net' ],
    'graylist-dir' => "#{node['spamdyke']['var_link']}/graylist",
    'graylist-level' => 'always',
    'graylist-max-secs' => 2_678_400,
    'graylist-min-secs' => 180,
    'greeting-delay-secs' => 5,
    'idle-timeout-secs' => 60,
    'ip-blacklist-file' => "#{node['spamdyke']['conf_link']}/blacklist_ip",
    'ip-in-rdns-keyword-blacklist-file' => "#{node['spamdyke']['conf_link']}/blacklist_keywords",
    'ip-in-rdns-keyword-whitelist-file' => "#{node['spamdyke']['conf_link']}/whitelist_keywords",
    'ip-whitelist-file' => "#{node['spamdyke']['conf_link']}/whitelist_ip",
    'local-domains-file' => "#{node['spamdyke']['qmail']['control']}/rcpthosts",
    'log-target' => 'stderr',
    'max-recipients' => 50,
    'rdns-blacklist-file' => "#{node['spamdyke']['conf_link']}/blacklist_rdns",
    'rdns-whitelist-file' => "#{node['spamdyke']['conf_link']}/whitelist_rdns",
    'recipient-blacklist-file' => "#{node['spamdyke']['conf_link']}/blacklist_recipients",
    'recipient-whitelist-file' => "#{node['spamdyke']['conf_link']}/whitelist_recipients",
    'reject-empty-rdns' => 'yes',
    'reject-missing-sender-mx' => 'yes',
    'reject-unresolvable-rdns' => 'yes',
    'sender-blacklist-file' => "#{node['spamdyke']['conf_link']}/blacklist_senders",
    'sender-whitelist-file' => "#{node['spamdyke']['conf_link']}/whitelist_senders",
    'tls-certificate-file' => "#{node['spamdyke']['qmail']['control']}/servercert.pem",
    'tls-level' => 'smtp',
    'log-level' => 'info'
}

# Blacklist entries
default['spamdyke']['config']['blacklist']['ip'] = []
default['spamdyke']['config']['blacklist']['rdns'] = []
default['spamdyke']['config']['blacklist']['keywords'] = []
default['spamdyke']['config']['blacklist']['recipients'] = []
default['spamdyke']['config']['blacklist']['senders'] = []

# Whitelist entries
default['spamdyke']['config']['whitelist']['ip'] = ['127.0.0.1']
default['spamdyke']['config']['whitelist']['rdns'] = []
default['spamdyke']['config']['whitelist']['keywords'] = []
default['spamdyke']['config']['whitelist']['recipients'] = []
default['spamdyke']['config']['whitelist']['senders'] = []
