require 'chefspec'

describe 'qmailtoaster::_configure_spamdyke' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'qmailtoaster::_configure_spamdyke' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
