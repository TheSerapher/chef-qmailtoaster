require 'chefspec'

describe 'qmailtoaster::_create_database' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::_create_database'
  }
  it 'should create database vpopmail' do
    pending 'Currently not being checked.'
  end
  it 'should create user vpopmail' do
    pending 'Currently not being checked.'
  end
  it 'should flush privileges' do
    pending 'Currently not being checked.'
  end
end
