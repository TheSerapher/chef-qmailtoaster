require 'chefspec'

describe 'qmailtoaster::_add_repositories' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new.converge 'qmailtoaster::_add_repositories'
  }
  it 'should include the yum::yum recipe' do
    @chef_run.should include_recipe 'yum::yum'
  end
  it 'should include the yum::repoforge recipe' do
    @chef_run.should include_recipe 'yum::repoforge'
  end
end
