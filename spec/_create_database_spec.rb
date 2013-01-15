require 'spec_helper'

describe 'qmailtoaster::_create_database' do
  before (:each) {
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.converge 'qmailtoaster::_create_database'
  }
  it 'should create database vpopmail' do
    @chef_run.should mysql_database 'vpopmail'
  end
  it 'should create user vpopmail' do
    @chef_run.should mysql_database_user 'vpopmail'
  end
  it 'should flush the privileges' do
    @chef_run.should mysql_database 'flush the privileges'
  end
end
