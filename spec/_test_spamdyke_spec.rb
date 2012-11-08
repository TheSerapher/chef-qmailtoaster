require 'chefspec'

describe 'qmailtoaster::_test_spamdyke' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new
  @chef_run.converge 'qmailtoaster::_test_spamdyke'
  }
  %w{ test-spamdyke }.each do |bs|
    it "should run bash script #{bs}" do
      @chef_run.should execute_bash_script bs
    end
  end
end
