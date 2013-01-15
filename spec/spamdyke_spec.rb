require 'chefspec'

describe 'qmailtoaster::spamdyke' do
  before (:all) {
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set["mysql"] = { "server_root_password" => "root", "server_debian_password" => "debian", "server_repl_password" => "repl" }
    @chef_run.converge 'qmailtoaster::spamdyke'
  }
  %w{
    qmailtoaster
    qmailtoaster::_pre_setup_spamdyke
    qmailtoaster::_install_spamdyke
    qmailtoaster::_configure_spamdyke
    qmailtoaster::_test_spamdyke
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      @chef_run.should include_recipe recipe
    end
  end
end
