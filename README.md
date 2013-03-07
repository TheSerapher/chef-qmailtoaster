Description  [ ![Codeship Status for TheSerapher/chef-qmailtoaster](https://www.codeship.io/projects/c6ea8420-4b94-0130-815e-12313928a5d9/status?branch=master)](https://www.codeship.io/projects/1313)
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

Build Status
============

This repository is tested against [codeship.io](http://www.codeship.io):

[ ![Codeship Status for TheSerapher/chef-qmailtoaster](https://www.codeship.io/projects/c6ea8420-4b94-0130-815e-12313928a5d9/status?branch=master)](https://www.codeship.io/projects/1313)

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
