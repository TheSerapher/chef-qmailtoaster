require 'chefspec'

describe 'qmailtoaster::_install_source_rpm_backend' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new(:step_into => ['qmailtoaster_rpmbuild']).converge 'qmailtoaster::_install_source_rpm_backend'
  }
  packages = [
      {"name" => "daemontools-toaster", "version" => "0.76-1.3.6"},
      {"name" => "ucspi-tcp-toaster", "version" => "0.88-1.3.9"},
      {"name" => "vpopmail-toaster", "version" => "5.4.33-1.4.0"},
      {"name" => "libdomainkeys-toaster", "version" => "0.68-1.3.6"},
      {"name" => "libsrs2-toaster", "version" => "1.0.18-1.3.6"},
      {"name" => "qmail-toaster", "version" => "1.03-1.3.22"},
      {"name" => "courier-authlib-toaster", "version" => "0.59.2-1.3.10"},
      {"name" => "courier-imap-toaster", "version" => "4.1.2-1.3.10"},
      {"name" => "autorespond-toaster", "version" => "2.0.5-1.4.0"},
      {"name" => "ezmlm-toaster", "version" => "0.53.324-1.3.6"},
      {"name" => "maildrop-toaster", "version" => "2.0.3-1.3.8"},
      {"name" => "spamassassin-toaster", "version" => "3.3.2-1.4.3"},
      {"name" => "clamav-toaster", "version" => "0.97.6-1.4.2"},
      {"name" => "ripmime-toaster", "version" => "1.4.0.6-1.3.6"},
      {"name" => "simscan-toaster", "version" => "1.4.0-1.4.0"}
  ]
  packages.each do |data|
    it "should compile and install #{data["name"]}" do
      @chef_run.should install_package data["name"]
    end
  end
  it "should enable and start service qmail" do
    @chef_run.should set_service_to_start_on_boot "qmail"
    @chef_run.should start_service "qmail"
  end
end
