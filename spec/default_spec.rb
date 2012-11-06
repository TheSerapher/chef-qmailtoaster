require File.expand_path('../spec_helper', __FILE__)

describe 'qmailtoaster::default' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::default'
  }
  %w{
    qmailtoaster::_add_repositories
    qmailtoaster::_pre_setup
    qmailtoaster::_install_dependencies
    qmailtoaster::_create_database
    qmailtoaster::_install_source_rpm
    qmailtoaster::_post_setup
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      @chef_run.should include_recipe recipe
    end
  end
end