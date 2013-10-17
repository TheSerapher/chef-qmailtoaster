# Encoding: UTF-8
require 'chefspec'

describe 'qmailtoaster::default' do
  before(:all) do
    stub_command('rpm -qa | grep -q \'^rpmforge-release-0.5.2-2\'').and_return(true)
    stub_command('rpm -qi postfix').and_return(true)
    stub_command('rpm -qi exim').and_return(true)
    stub_command('rpm -qi sendmail').and_return(true)
    stub_command('"/usr/bin/mysql" -u root -e \'show databases;\'').and_return(true)
    %w{ daemontools-toaster ucspi-tcp-toaster vpopmail-toaster libdomainkeys-toaster
        libsrs2-toaster qmail-toaster courier-authlib-toaster courier-imap-toaster
        autorespond-toaster ezmlm-toaster maildrop-toaster spamassassin-toaster
        clamav-toaster ripmime-toaster simscan-toaster}.each do |package|
      stub_command("rpm -qi #{package}").and_return(false)
    end
    @chef_run = ChefSpec::ChefRunner.new(step_into: ['qmailtoaster_rpmbuild'])
    @chef_run.node.set['mysql'] = { 'server_root_password' => 'root', 'server_debian_password' => 'debian',
                                    'server_repl_password' => 'repl' }
    @chef_run.node.set['qmailtoaster']['vpopmail']['database']['password'] = 'chefspec_password'
    @chef_run.node.set['platform_family'] = 'rhel'
    @chef_run.converge 'qmailtoaster::default'
  end
  before do
    stub_command("rpm -qa | grep -q '^rpmforge-release-0.5.2-2'").and_return(true)
  end
  %w{
    build-essential
    mysql
    mysql::server
    qmailtoaster::_add_repositories
    qmailtoaster::_pre_setup
    qmailtoaster::_install_dependencies_backend
    qmailtoaster::_install_source_rpm_backend
    qmailtoaster::_post_setup
    qmailtoaster::_create_database
    qmailtoaster::_configure_qmail
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      expect(@chef_run).to include_recipe recipe
    end
  end
  it 'should include the yum::yum recipe' do
    expect(@chef_run).to include_recipe 'yum::yum'
  end
  it 'should include the yum::repoforge recipe' do
    expect(@chef_run).to include_recipe 'yum::repoforge'
  end
  %w{rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 bzip2 bzip2-devel bzip2-libs
     compat-gcc-34 compat-gcc-34-c++ compat-glibc compat-glibc-headers curl libcurl-devel expect
     expect-devel gdbm gdbm-devel gmp gmp-devel groff httpd-devel httpd-manual krb5-auth-dialog
     krb5-devel krb5-libs krb5-workstation libgcc libidn libidn-devel libtool libtool-ltdl
     libtool-ltdl-devel mysql-bench openssl-devel pcre-devel procmail ruby-mysql
     perl-libwww-perl perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser
     perl-Net-DNS perl-Time-HiRes perl-Mail-SPF-Query perl-ExtUtils-MakeMaker perl-NetAddr-IP
     sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
     redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python
  }.each do |pkg|
    it "should install package #{pkg}" do
      expect(@chef_run).to install_package pkg
    end
  end
  packages = [
    { 'name' => 'daemontools-toaster', 'version' => '0.76-1.3.6' },
    { 'name' => 'ucspi-tcp-toaster', 'version' => '0.88-1.3.9' },
    { 'name' => 'vpopmail-toaster', 'version' => '5.4.33-1.4.0' },
    { 'name' => 'libdomainkeys-toaster', 'version' => '0.68-1.3.6' },
    { 'name' => 'libsrs2-toaster', 'version' => '1.0.18-1.3.6' },
    { 'name' => 'qmail-toaster', 'version' => '1.03-1.3.22' },
    { 'name' => 'courier-authlib-toaster', 'version' => '0.59.2-1.3.10' },
    { 'name' => 'courier-imap-toaster', 'version' => '4.1.2-1.3.10' },
    { 'name' => 'autorespond-toaster', 'version' => '2.0.5-1.4.0' },
    { 'name' => 'ezmlm-toaster', 'version' => '0.53.324-1.3.6' },
    { 'name' => 'maildrop-toaster', 'version' => '2.0.3-1.3.8' },
    { 'name' => 'spamassassin-toaster', 'version' => '3.3.2-1.4.3' },
    { 'name' => 'clamav-toaster', 'version' => '0.97.6-1.4.2' },
    { 'name' => 'ripmime-toaster', 'version' => '1.4.0.6-1.3.6' },
    { 'name' => 'simscan-toaster', 'version' => '1.4.0-1.4.0' }
  ]
  packages.each do |data|
    it "should compile and install #{data['name']}" do
      expect(@chef_run).to install_package data['name']
    end
  end
  it 'should enable service qmail' do
    expect(@chef_run).to set_service_to_start_on_boot 'qmail'
  end
  it 'should create /home/vpopmail/etc/vpopmail.mysql with password chefspec_password' do
    expect(@chef_run).to render_file(
      '/home/vpopmail/etc/vpopmail.mysql'
    ).with_content(
      'localhost|0|vpopmail|chefspec_password|vpopmail'
    )
  end
  it 'should create file /var/qmail/supervise/submission/run' do
    expect(@chef_run).to render_file '/var/qmail/supervise/submission/run'
  end
end
