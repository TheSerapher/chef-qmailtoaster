require 'chefspec'

describe 'qmailtoaster::_post_setup' do
  before (:all) {
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set["qmailtoaster"]["vpopmail"]["database"]["password"] = "chefspec_password"
    @chef_run.converge 'qmailtoaster::_post_setup'
  }
  it "should include the qmailtoaster::_create_database recipe" do
    @chef_run.should include_recipe "qmailtoaster::_create_database"
  end
  it 'should create /home/vpopmail/etc/vpopmail.mysql with password chefspec_password' do
    @chef_run.should create_file_with_content("/home/vpopmail/etc/vpopmail.mysql", "localhost|0|vpopmail|chefspec_password|vpopmail")
  end
end
