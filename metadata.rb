maintainer       "Sebastian Grewe"
maintainer_email "sebastian@grewe.ca"
license          "All rights reserved"
description      "Installs/Configures qmailtoaster, currently only using supplied configurations by RPM packages."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe           "qmailtoaster", "Installs and configures a qmail toaster installation"
recipe           "qmailtoaster::_add_repositories", "Included by default: Adds required RPMForge Repository"
recipe           "qmailtoaster::_pre_setup", "Included by default: Removes pre-installed mail server and installs ssmtp for dependency satisfaction"
recipe           "qmailtoaster::_install_dependencies", "Included by default: Installs are depending packages for the build process"
recipe           "qmailtoaster::_install_source_rpm", "Included by default: rpmbuilds and installs all source rpms"

attribute "qmailtoaster/packages/required",
  :display_name => "Required Packages",
  :description => "List of packages that are required for the entire build process and setup.",
  :default => "rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 aspell bzip2 bzip2-devel bzip2-libs compat-gcc-34 compat-gcc-34-c++ compat-glibc compat-glibc-headers curl libcurl-devel expect expect-devel gdbm gdbm-devel gmp gmp-devel groff httpd-devel httpd-manual krb5-auth-dialog krb5-devel krb5-libs krb5-workstation libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel mysql-bench mrtg openssl-devel pcre-devel php-ldap procmail perl-libwww-perl perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser perl-Net-DNS perl-Time-HiRes perl-Mail-SPF-Query perl-ExtUtils-MakeMaker perl-NetAddr-IP sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python"

attribute "qmailtoaster/packages/sources",
  :display_name => "Source RPMs",
  :description => "(sorted) array with hashes for all source rpms that will be built.",
  :default => ""

attribute "qmailtoaster/workspace",
  :display_name => "rpmbuild Workspace",
  :description => "Location where all SRPMs are placed and compiled, then installed.",
  :default => "/root/rpmbuild"

supports "centos", ">= 6.0"

depends "apache2", ">= 1.2.0"
depends "build-essential", ">= 1.1.2"
depends "mysql", ">= 1.3.0"
depends "openssl", ">= 1.0.0"
depends "perl", ">= 1.0.2"
depends "php", ">= 1.1.0"
