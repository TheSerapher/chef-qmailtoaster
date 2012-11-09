maintainer       "Sebastian Grewe"
maintainer_email "sebastian@grewe.ca"
license          "All rights reserved"
description      "Installs/Configures qmailtoaster and Spamdyke (optional)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

recipe           "qmailtoaster", "Installs and configures a qmail toaster installation, includes many sub-recipes"
recipe           "qmailtoaster::_add_repositories", "Included by default: Adds required RPMForge Repository"
recipe           "qmailtoaster::_pre_setup", "Included by default: Removes pre-installed mail server and installs ssmtp for dependency satisfaction"
recipe           "qmailtoaster::_install_dependencies", "Included by default: Installs are depending packages for the build process"
recipe           "qmailtoaster::_install_source_rpm", "Included by default: rpmbuilds and installs all source rpms"
recipe           "qmailtoaster::_create_database", "Included by default: Create vpopmail database and grant access to vpopmail user with default password"
recipe           "qmailtoaster::_post_setup", "Included by default: Finishes the installation by writing some custom templates"
recipe           "qmailtoaster::spamdyke", "Install and configure spamdyke using node variables, include sub-recipes"
recipe           "qmailtoaster::_pre_setup_spamdyke", "Included by spamdyke: Install dependencies and create directories"
recipe           "qmailtoaster::_install_spamdyke", "Included by spamdyke: Downloads spamdyke source and installs it"
recipe           "qmailtoaster::_configure_spamdyke", "Included by spamdyke: Configures spamdyke main configuration and black-/whitelists"
recipe           "qmailtoaster::_test_spamdyke", "Included by spamdyke: Tests the current spamdyke configuration"

attribute "qmailtoaster/packages/sources",
  :display_name => "Source RPMs",
  :description => "(sorted) array with hashes for all source rpms that will be built.",
  :default => ""

attribute "qmailtoaster/vpopmail/database/password",
  :display_name => "Database Password",
  :description => "vpopmail user database password, will be set after installation completes",
  :default => "SsEeCcRrEeT"

attribute "spamdyke/version",
          :display_name => "Spamdyke Version",
          :description => "Spamdyke version to install.",
          :default => "4.3.1"

attribute "spamdyke/source/url",
          :display_name => "Spamdyke URL",
          :description => "Download URL to fetch source from.",
          :default => "http://www.spamdyke.org/releases"

attribute "spamdyke/source/directory",
          :display_name => "Source Directory",
          :description => "Download and extract files here.",
          :default => "/usr/src/spamdyke"

attribute "spamdyke/base_dir",
          :display_name => "Base Directory",
          :description => "Base directory for spamdyke installation.",
          :default => "/opt/spamdyke"

attribute "spamdyke/config/main",
          :display_name => "Various configuration variables",
          :description => "Any key/value pair here will be included in the spamdyke.conf. See spamdyke.rb attributes file.",
          :default => ""

attribute "spamdyke/config/whitelist/ip",
          :display_name => "IP Whitelist",
          :description => "IP whitelist entries.",
          :default => ""

attribute "spamdyke/config/whitelist/rdns",
          :display_name => "RDNS Whitelist",
          :description => "RDNS whitelist entries.",
          :default => ""

attribute "spamdyke/config/whitelist/sender",
          :display_name => "Sende Whitelist",
          :description => "Sender whitelist entries.",
          :default => ""

attribute "spamdyke/config/whitelist/recipient",
          :display_name => "Recipient Whitelist",
          :description => "Recipient whitelist entries.",
          :default => ""

attribute "spamdyke/config/whitelist/keywords",
          :display_name => "keywords Whitelist",
          :description => "Keywords whitelist entries.",
          :default => ""

attribute "spamdyke/config/blacklist/ip",
          :display_name => "IP Blacklist",
          :description => "IP blacklist entries.",
          :default => ""

attribute "spamdyke/config/blacklist/rdns",
          :display_name => "RDNS Blacklist",
          :description => "RDNS blacklist entries.",
          :default => ""

attribute "spamdyke/config/blacklist/sender",
          :display_name => "Sender Blacklist",
          :description => "Sender blacklist entries.",
          :default => ""

attribute "spamdyke/config/blacklist/recipient",
          :display_name => "Recipient Blacklist",
          :description => "Recipient blacklist entries.",
          :default => ""

attribute "spamdyke/config/blacklist/keywords",
          :display_name => "Keywords Blacklist",
          :description => "Keywords blacklist entries.",
          :default => ""

supports "centos", ">= 6.0"

depends "apache2", ">= 1.2.0"
depends "build-essential", ">= 1.1.2"
depends "mysql", ">= 1.3.0"
depends "openssl", ">= 1.0.0"
depends "perl", ">= 1.0.2"
depends "php", ">= 1.1.0"
depends "database", ">= 1.3.6"
depends "openssl", ">= 1.0.0"
depends "yum", ">= 1.0.1"
