Description
===========

Installs/Configures qmailtoaster, currently only using supplied configurations by RPM packages.

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

Attributes
==========

* `node['qmailtoaster']['packages']['required']` - List of packages that are required for the entire build process and setup.
* `node['qmailtoaster']['packages']['sources']` - (sorted) array with hashes for all source rpms that will be built.
* `node['qmailtoaster']['workspace']` - Location where all SRPMs are placed and compiled, then installed.
* `node['qmailtoaster']['vpopmail']['database']['password']` - vpopmail user database password, will be set after installation completes

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


License and Author
==================

Author:: Sebastian Grewe (<sebastian@grewe.ca>)

Copyright:: 2012, Sebastian Grewe

License:: All rights reserved
