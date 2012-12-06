require 'chefspec'

describe 'qmailtoaster::_install_spamdyke' do
  before (:all) {
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.converge 'qmailtoaster::_install_spamdyke'
  }
  it 'should create remote file /usr/src/spamdyke/spamdyke-4.3.1.tgz' do
    @chef_run.should create_remote_file '/usr/src/spamdyke/spamdyke-4.3.1.tgz'
  end
  %w{ unpack-spamdyke compile-spamdyke install-spamdyke }.each do |bs|
    it "should run bash script #{bs}" do
      @chef_run.should execute_bash_script bs
    end
  end
end
