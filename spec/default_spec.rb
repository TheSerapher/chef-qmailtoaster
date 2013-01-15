require File.expand_path('../spec_helper', __FILE__)

describe 'qmailtoaster::default' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new
      @chef_run.node.set["mysql"] = { "server_root_password" => "root", "server_debian_password" => "debian", "server_repl_password" => "repl" }
      @chef_run.converge 'qmailtoaster::default'
  }
  %w{
    qmailtoaster::_add_repositories
    qmailtoaster::_pre_setup
    qmailtoaster::_install_dependencies_backend
    qmailtoaster::_install_source_rpm_backend
    qmailtoaster::_post_setup
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      @chef_run.should include_recipe recipe
    end
  end
end
