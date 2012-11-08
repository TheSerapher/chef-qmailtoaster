require 'chefspec'

describe 'qmailtoaster::_pre_setup_spamdyke' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new
  @chef_run.converge 'qmailtoaster::_pre_setup_spamdyke'
  }
  %w{
    build-essential
  }.each do |recipe|
    it "should include the #{recipe} recipe" do
      @chef_run.should include_recipe recipe
    end
  end
  %w{
    /usr/src/spamdyke
    /opt/spamdyke
    /opt/spamdyke/bin
    /opt/spamdyke/etc
    /opt/spamdyke/var
    /opt/spamdyke/var/graylist
  }.each do |dir|
    it "should create directory #{dir}" do
      @chef_run.should create_directory dir
    end
  end
  it "should create link /etc/spamdyke" do
    @chef_run.should create_link "/etc/spamdyke"
    @chef_run.link("/etc/spamdyke").should link_to('/opt/spamdyke/etc')
  end
  it "should create link /var/spamdyke" do
    @chef_run.should create_link "/var/spamdyke"
    @chef_run.link("/var/spamdyke").should link_to('/opt/spamdyke/var')
  end
end
