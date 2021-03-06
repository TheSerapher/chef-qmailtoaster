Description
===========

Installs/Configures [qmailtoaster](http://www.qmailtoaster.com) and [Spamdyke](http://www.spamdyke.org) (optional).
It keeps most of the deployed package defaults but overwrites some
settings to ensure things (run files) work as expected.

Requirements
============

Only CentOS 6.3+ is currently supported.

## Platform:

* centos

## Cookbooks:

* apache2
* build-essential
* mysql
* openssl
* perl
* php
* database
* yum

Attributes
==========

We are overwriting one default attribute of the `build_essential`
cookbook to ensure these tools are installed during compile time. Other
attributes in this cookbook:

| Attribute                                                  | Description                                                                                     |
| :-------------                                             | :-------------                                                                                  |
| `node['qmailtoaster']['packages']['required']`             | List of packages that are required for the entire build process and setup.                      |
| `node['qmailtoaster']['packages']['sources']`              | (sorted) array with hashes for all source rpms that will be built.                              |
| `node['qmailtoaster']['workspace']`                        | Location where all SRPMs are placed and compiled, then installed.                               |
| `node['qmailtoaster']['vpopmail']['database']['password']` | vpopmail user database password, will be set after installation completes.                      |
| `node['spamdyke']['version']`                              | Spamdyke version to install.                                                                    |
| `node['spamdyke']['source']['url']`                        | Download URL to fetch source from.                                                              |
| `node['spamdyke']['source']['directory']`                  | Download and extract files here.                                                                |
| `node['spamdyke']['base_dir']`                             | Base directory for spamdyke installation.                                                       |
| `node['spamdyke']['config']['main']`                       | Any key/value pair here will be included in the spamdyke.conf. See spamdyke.rb attributes file. |
| `node['spamdyke']['config']['whitelist']['ip']`            | IP whitelist entries.                                                                           |
| `node['spamdyke']['config']['whitelist']['rdns']`          | RDNS whitelist entries.                                                                         |
| `node['spamdyke']['config']['whitelist']['sender']`        | Sender whitelist entries.                                                                       |
| `node['spamdyke']['config']['whitelist']['recipient']`     | Recipient whitelist entries.                                                                    |
| `node['spamdyke']['config']['whitelist']['keywords']`      | Keywords whitelist entries.                                                                     |
| `node['spamdyke']['config']['blacklist']['ip']`            | IP blacklist entries.                                                                           |
| `node['spamdyke']['config']['blacklist']['rdns']`          | RDNS blacklist entries.                                                                         |
| `node['spamdyke']['config']['blacklist']['sender']`        | Sender blacklist entries.                                                                       |
| `node['spamdyke']['config']['blacklist']['recipient']`     | Recipient blacklist entries.                                                                    |
| `node['spamdyke']['config']['blacklist']['keywords']`      | Keywords blacklist entries.                                                                     |

Recipes
=======

| Recipe Name            | Description                                                                                                                                                                         |
| :---                   | :---                                                                                                                                                                                |
| `qmailtoaster::default`  | Installs and configures a qmail toaster installation, includes many sub-recipes. These sub-tasks start with an underscore and are located in the [recipes](recipes) directory. |
| `qmailtoaster::spamdyke` | Install and configure spamdyke using node variables, includes sub-recipes. These sub-tasks start with an underscore and are located in the [recipes](recipes) directory.            |

Testing
=======

The cookbook comes with some testing facilities allowing you to iterate quickly
on cookbook changes.

## Rake

You can execute the tests with [Rake](http://rake.rubyforge.org). The Rakefile
provides the following tasks:

    $ rake -T
    rake chefspec    # Run ChefSpec examples
    rake foodcritic  # Run Foodcritic lint checks
    rake knife       # Run knife cookbook test
    rake test        # Run all tests

## Bundler

If you prefer to let [Bundler](http://gembundler.com) install all required gems
(you should), run the tests this way:

    $ bundle install
    $ bundle exec rake test

## Berkshelf

[Berkshelf](http://berkshelf.com) is used to set up the cookbook and its 
dependencies (as defined in Berksfile) prior to testing with Rake and Vagrant.

## Vagrant

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run 
your cookbook inside it via Chef Solo.

This command will boot and provision the VM as specified in the Vagrantfile:

    $ bundle exec vagrant up <name>

Name refers to any box setup by test-kitchen, see below.

(Berkshelf's Vagrant plugin will make your cookbook and its dependencies
automatically available to Vagrant when creating or provisioning a VM.)

## Kitchen

This cookbook is using [test-kitchen](https://github.com/opscode/test-kitchen)  to propagate the Vagrantfile. You 
can review the boxes by using:

    $ bundle exec kitchen list

Each item in this list is a regular vagrant box that can be started as
usual.

To run the full kitchen suite included in this cookbook simply execute:

    $ bundle exec kitchen test


License and Author
==================

Author:: Sebastian Grewe (<sebastian.grewe@gmail.com>) 

Website:: http://www.grewe.ca

Copyright:: 2013, Sebastian Grewe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
