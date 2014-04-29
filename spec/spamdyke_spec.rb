# Encoding: UTF-8
require 'chefspec'

describe 'qmailtoaster::spamdyke' do
  before(:all) do
    stub_command('rpm -qa | grep -q \'^rpmforge-release-0.5.2-2\'').and_return(true)
    stub_command('rpm -qi postfix').and_return(true)
    stub_command('rpm -qi exim').and_return(true)
    stub_command('rpm -qi sendmail').and_return(true)
    stub_command('"/usr/bin/mysql" -u root -e \'show databases;\'').and_return(true)
    stub_command('test -f /usr/src/spamdyke/spamdyke-4.3.1.tgz').and_return(false)
    stub_command('test -d /usr/src/spamdyke/spamdyke-4.3.1').and_return(false)
    stub_command('/opt/spamdyke/bin/spamdyke -v 2>&1 | grep -q \'spamdyke 4.3.1\'').and_return(false)
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set['mysql'] = {
      'server_root_password' => 'root', 'server_debian_password' => 'debian',
      'server_repl_password' => 'repl'
    }
    @chef_run.node.set['platform_family'] = 'rhel'
    @chef_run.converge 'qmailtoaster::spamdyke'
  end
  %w{
    build-essential
    qmailtoaster
    qmailtoaster::_pre_setup_spamdyke
    qmailtoaster::_install_spamdyke
    qmailtoaster::_configure_spamdyke
    qmailtoaster::_test_spamdyke
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      expect(@chef_run).to include_recipe recipe
    end
  end
  %w(/usr/src/spamdyke
     /opt/spamdyke
     /opt/spamdyke/bin
     /opt/spamdyke/etc
     /opt/spamdyke/var
     /opt/spamdyke/var/graylist).each do |dir|
    it "should create directory #{dir}" do
      expect(@chef_run).to create_directory dir
    end
  end
  it 'should create link /etc/spamdyke' do
    expect(@chef_run).to create_link '/etc/spamdyke'
    @chef_run.link('/etc/spamdyke').should link_to('/opt/spamdyke/etc')
  end
  it 'should create link /var/spamdyke' do
    expect(@chef_run).to create_link '/var/spamdyke'
    @chef_run.link('/var/spamdyke').should link_to('/opt/spamdyke/var')
  end
  it 'should create remote file /usr/src/spamdyke/spamdyke-4.3.1.tgz' do
    expect(@chef_run).to create_remote_file '/usr/src/spamdyke/spamdyke-4.3.1.tgz'
  end
  %w{ unpack-spamdyke compile-spamdyke install-spamdyke }.each do |bs|
    it "should run bash script #{bs}" do
      expect(@chef_run).to run_bash bs
    end
  end
  it 'should create file /opt/spamdyke/etc/spamdyke.conf' do
    expect(@chef_run).to render_file '/opt/spamdyke/etc/spamdyke.conf'
  end
  %w{blacklist whitelist}.each do |list|
    %w{ip rdns keywords recipients senders}.each do |type|
      it "should create file /opt/spamdyke/etc/#{list}_#{type}" do
        expect(@chef_run).to render_file "/opt/spamdyke/etc/#{list}_#{type}"
      end
    end
  end
  it 'should create file /var/qmail/supervise/smtp/run' do
    expect(@chef_run).to create_file_with_content('/var/qmail/supervise/smtp/run',
                                                  'SPAMDYKE="/opt/spamdyke/bin/spamdyke"')
    expect(@chef_run).to create_file_with_content('/var/qmail/supervise/smtp/run',
                                                  'SPAMDYKE_CONF="/etc/spamdyke/spamdyke.conf"')
    expect(@chef_run).to create_file_with_content('/var/qmail/supervise/smtp/run',
                                                  '$SPAMDYKE --config-file $SPAMDYKE_CONF')
  end
  %w{ test-spamdyke }.each do |bs|
    it "should run bash script #{bs}" do
      expect(@chef_run).to run_bash bs
    end
  end
end
