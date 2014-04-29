require 'chef/cookbook/metadata'
require 'ci/reporter/rake/rspec'

def cookbook_metadata
  metadata = Chef::Cookbook::Metadata.new
  metadata.from_file 'metadata.rb'
  metadata
end

def cookbook_name
  name = cookbook_metadata.name
  if name.nil? || name.empty?
    File.basename(File.dirname(__FILE__))
  else
    name
  end
end

VAGRANT = ENV['VAGRANT'] || false
COOKBOOK_NAME = ENV['COOKBOOK_NAME'] || cookbook_name
COOKBOOKS_PATH = ENV['COOKBOOKS_PATH'] || 'cookbooks'

desc 'Install cookbooks from Berksfile'
task :setup_cookbooks do
  rm_rf COOKBOOKS_PATH
  sh 'berks', 'install', '--path', COOKBOOKS_PATH
end

desc 'Run knife cookbook test'
task :knife => :setup_cookbooks do
  sh 'knife', 'cookbook', 'test', COOKBOOK_NAME, '--config', 'knife.rb',
    '--cookbook-path', COOKBOOKS_PATH
end

desc 'Run Foodcritic lint checks'
task :foodcritic => :setup_cookbooks do
  sh 'foodcritic', '--epic-fail', 'any',
    File.join(COOKBOOKS_PATH, COOKBOOK_NAME)
end

desc 'Run ChefSpec examples'
task :chefspec => [:setup_cookbooks, 'ci:setup:rspec'] do
  sh 'rspec', '--color', '--format', 'documentation',
    File.join(COOKBOOKS_PATH, COOKBOOK_NAME, 'spec')
end

desc 'Run Rubocop'
task :rubocop do
  sh 'rubocop', '-fs'
end

desc 'Run Kitchen'
task :kitchen do
  sh 'kitchen', 'test'
end

desc 'Run Vagrant'
task :vagrant do
  if VAGRANT
    rm_rf 'spec/reports/minitest'
    sh 'vagrant', 'up'
    sh 'vagrant', 'destroy', '-f'
  end
end

desc 'Run all tests'
task :test => [:knife, :foodcritic, :chefspec, :rubocop, :vagrant]

# Default, test everything
task :default => :test

# aliases
task :lint => :foodcritic

# Cleanup testing cookbooks
at_exit { rm_rf COOKBOOKS_PATH }
