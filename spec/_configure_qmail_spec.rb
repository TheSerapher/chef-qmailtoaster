require 'spec_helper'

describe 'qmailtoaster::_configure_qmail' do
  before(:all) {
    @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::_configure_qmail'
  }
  it "should create file /var/qmail/supervise/submission/run" do
    @chef_run.should create_file "/var/qmail/supervise/submission/run"
  end
end
