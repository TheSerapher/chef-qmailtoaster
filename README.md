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

Attributes
==========

* `node['qmailtoaster']['packages']['required']` - List of packages that are required for the entire build process and setup.
* `node['qmailtoaster']['packages']['sources']` - (sorted) array with hashes for all source rpms that will be built.
* `node['qmailtoaster']['workspace']` - Location where all SRPMs are placed and compiled, then installed.

Recipes
=======

## qmailtoaster

Installs and configures a qmail toaster installation

## qmailtoaster::_add_repositories

Included by default: Adds required RPMForge Repository

## qmailtoaster::_pre_setup

Included by default: Removes pre-installed mail server and installs ssmtp for dependency satisfaction

## qmailtoaster::_install_dependencies

Included by default: Installs are depending packages for the build process

## qmailtoaster::_install_source_rpm

Included by default: rpmbuilds and installs all source rpms


License and Author
==================

Author:: Sebastian Grewe (<sebastian@grewe.ca>)

Copyright:: 2012, Sebastian Grewe

License:: All rights reserved
