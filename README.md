Description  [ ![Codeship Status for TheSerapher/chef-qmailtoaster](https://www.codeship.io/projects/c6ea8420-4b94-0130-815e-12313928a5d9/status?branch=master)](https://www.codeship.io/projects/1313) [![Build Status](https://travis-ci.org/TheSerapher/chef-qmailtoaster.png)](https://travis-ci.org/TheSerapher/chef-qmailtoaster) 
===========

Installs/Configures qmailtoaster and Spamdyke (optional)

Requirements
============

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

* `node['qmailtoaster']['packages']['required']` - List of packages that are required for the entire build process and setup.
* `node['qmailtoaster']['packages']['sources']` - (sorted) array with hashes for all source rpms that will be built.
* `node['qmailtoaster']['workspace']` - Location where all SRPMs are placed and compiled, then installed.
* `node['qmailtoaster']['vpopmail']['database']['password']` - vpopmail user database password, will be set after installation completes
* `node['spamdyke']['version']` - Spamdyke version to install.
* `node['spamdyke']['source']['url']` - Download URL to fetch source from.
* `node['spamdyke']['source']['directory']` - Download and extract files here.
* `node['spamdyke']['base_dir']` - Base directory for spamdyke installation.
* `node['spamdyke']['config']['main']` - Any key/value pair here will be included in the spamdyke.conf. See spamdyke.rb attributes file.
* `node['spamdyke']['config']['whitelist']['ip']` - IP whitelist entries.
* `node['spamdyke']['config']['whitelist']['rdns']` - RDNS whitelist entries.
* `node['spamdyke']['config']['whitelist']['sender']` - Sender whitelist entries.
* `node['spamdyke']['config']['whitelist']['recipient']` - Recipient whitelist entries.
* `node['spamdyke']['config']['whitelist']['keywords']` - Keywords whitelist entries.
* `node['spamdyke']['config']['blacklist']['ip']` - IP blacklist entries.
* `node['spamdyke']['config']['blacklist']['rdns']` - RDNS blacklist entries.
* `node['spamdyke']['config']['blacklist']['sender']` - Sender blacklist entries.
* `node['spamdyke']['config']['blacklist']['recipient']` - Recipient blacklist entries.
* `node['spamdyke']['config']['blacklist']['keywords']` - Keywords blacklist entries.

Recipes
=======

## qmailtoaster

Installs and configures a qmail toaster installation, includes many sub-recipes

## qmailtoaster::_add_repositories

Included by default: Adds required RPMForge Repository

## qmailtoaster::_pre_setup

Included by default: Removes pre-installed mail server and installs ssmtp for dependency satisfaction

## qmailtoaster::_install_dependencies

Included by default: Installs are depending packages for the build process

## qmailtoaster::_install_source_rpm

Included by default: rpmbuilds and installs all source rpms

## qmailtoaster::_create_database

Included by default: Create vpopmail database and grant access to vpopmail user with default password

## qmailtoaster::_post_setup

Included by default: Finishes the installation by writing some custom templates

## qmailtoaster::spamdyke

Install and configure spamdyke using node variables, include sub-recipes

## qmailtoaster::_pre_setup_spamdyke

Included by spamdyke: Install dependencies and create directories

## qmailtoaster::_install_spamdyke

Included by spamdyke: Downloads spamdyke source and installs it

## qmailtoaster::_configure_spamdyke

Included by spamdyke: Configures spamdyke main configuration and black-/whitelists

## qmailtoaster::_test_spamdyke

Included by spamdyke: Tests the current spamdyke configuration

Build Status
============

This repository is tested against travis-ci.org and codeship.io:

[![Build Status](https://travis-ci.org/TheSerapher/chef-qmailtoaster.png)](https://travis-ci.org/TheSerapher/chef-qmailtoaster)
[ ![Codeship Status for TheSerapher/chef-qmailtoaster](https://www.codeship.io/projects/c6ea8420-4b94-0130-815e-12313928a5d9/status?branch=master)](https://www.codeship.io/projects/1313)


License and Author
==================

Author:: Sebastian Grewe (<sebastian@grewe.ca>)

Copyright:: 2012, Sebastian Grewe

License:: All rights reserved
