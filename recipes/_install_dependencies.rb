# Include required recipes
include_recipe "build-essential"
include_recipe "mysql"
include_recipe "mysql::server"
include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_mysql"

node["qmailtoaster"]["packages"]["required"].each do |pkg|
  package pkg
end
