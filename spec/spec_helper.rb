require 'chefspec'

module ChefSpec
  module Matchers
    # Check whether a recipe was included (backported from ChefSpec master).
    # Example: chef_run.should include_recipe 'foo::bar'
    RSpec::Matchers.define :include_recipe do |expected_recipe|
      match do |chef_run|
        actual_recipes = chef_run.node.run_state[:seen_recipes]
        actual_recipes.include?(expected_recipe)
      end
    end

    # Check whether a bash script was run.
    # Example: chef_run.should execute_bash_script 'name-of-script'
    RSpec::Matchers.define :execute_bash_script do |name|
      match do |chef_run|
        chef_run.resources.any? do |resource|
          resource.resource_name.to_s == 'bash' && resource.name == name
        end
      end
    end

    # Check whether a file/directory has a specific mode.
    # Example: chef_run.directory('path/to/dir').should have_mode(0700)
    RSpec::Matchers.define :have_mode do |mode|
      match do |file|
        file.nil? ? false : file.mode == mode.to_i
      end
    end
  end
end