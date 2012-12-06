require 'spec_helper'

describe 'qmailtoaster::_configure_spamdyke' do
  before (:all) {
    @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::_configure_spamdyke'
  }
  it 'should create file /opt/spamdyke/etc/spamdyke.conf' do
    @chef_run.should create_file '/opt/spamdyke/etc/spamdyke.conf'
  end
  %w{blacklist whitelist}.each do |list|
    %w{ip rdns keywords recipients senders}.each do |type|
      it "should create file /opt/spamdyke/etc/#{list}_#{type}" do
        @chef_run.should create_file "/opt/spamdyke/etc/#{list}_#{type}"
      end
    end
  end
  it 'should create file /var/qmail/supervise/smtp/run' do
    @chef_run.should create_file_with_content('/var/qmail/supervise/smtp/run', 'SPAMDYKE="/opt/spamdyke/bin/spamdyke"')
    @chef_run.should create_file_with_content('/var/qmail/supervise/smtp/run', 'SPAMDYKE_CONF="/etc/spamdyke/spamdyke.conf"')
    @chef_run.should create_file_with_content('/var/qmail/supervise/smtp/run', '$SPAMDYKE --config-file $SPAMDYKE_CONF')
  end
end
