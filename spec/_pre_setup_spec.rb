require 'chefspec'

describe 'qmailtoaster::_pre_setup' do
  before (:all) {
    @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::_pre_setup'
  }
  %w{ postfix exim sendmail }.each do |pkg|
    it "should remove package #{pkg}" do
      @chef_run.should remove_package pkg
    end
  end
end
