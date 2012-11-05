actions :install
default_action :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :required => true