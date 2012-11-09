require 'chefspec'

describe 'qmailtoaster::_install_source_rpm_frontend' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new(:step_into => ['qmailtoaster_rpmbuild']).converge 'qmailtoaster::_install_source_rpm_frontend'
  }
  packages = [
      {"name" => "control-panel-toaster", "version" => "0.5-1.4.0", "arch" => "noarch"},
      {"name" => "qmailadmin-toaster", "version" => "1.2.16-1.4.0"},
      {"name" => "qmailmrtg-toaster", "version" => "4.2-1.3.7"},
      {"name" => "isoqlog-toaster", "version" => "2.1-1.3.7"},

  ]
  packages.each do |data|
    it "should compile and install #{data["name"]}" do
      @chef_run.should install_package data["name"]
    end
  end
end
