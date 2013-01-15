#
# Cookbook Name:: qmailtoaster
# Recipe:: _pre_configuration
#
# Copyright 2012, Sebastian Grewe
#
# All rights reserved - Do Not Redistribute

# Our workspace to download the SRPMs too
default['qmailtoaster']['workspace'] = '/root/rpmbuild'

# Package dependency list
default['qmailtoaster']['packages']['backend']['required'] = %w{
  rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 bzip2 bzip2-devel bzip2-libs compat-gcc-34
  compat-gcc-34-c++ compat-glibc compat-glibc-headers curl libcurl-devel expect
  expect-devel gdbm gdbm-devel gmp gmp-devel groff httpd-devel httpd-manual krb5-auth-dialog
  krb5-devel krb5-libs krb5-workstation libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel
  mysql-bench openssl-devel pcre-devel procmail ruby-mysql
  perl-libwww-perl perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser perl-Net-DNS perl-Time-HiRes
  perl-Mail-SPF-Query perl-ExtUtils-MakeMaker perl-NetAddr-IP
  sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
  redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python
}

# Package dependency list
default['qmailtoaster']['packages']['frontend']['required'] = %w{
  rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 aspell bzip2 bzip2-devel bzip2-libs compat-gcc-34
  compat-gcc-34-c++ compat-glibc compat-glibc-headers curl libcurl-devel expect
  expect-devel gdbm gdbm-devel gmp gmp-devel groff httpd-devel httpd-manual krb5-auth-dialog
  libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel
  mysql-bench mrtg openssl-devel pcre-devel php-ldap procmail ruby-mysql
  sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
  redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python
}

# Our packages and their versions
default['qmailtoaster']['packages']['backend']['sources'] = [
    {'name' => 'daemontools-toaster', 'version' => '0.76-1.3.6'},
    {'name' => 'ucspi-tcp-toaster', 'version' => '0.88-1.3.9'},
    {'name' => 'vpopmail-toaster', 'version' => '5.4.33-1.4.0'},
    {'name' => 'libdomainkeys-toaster', 'version' => '0.68-1.3.6'},
    {'name' => 'libsrs2-toaster', 'version' => '1.0.18-1.3.6'},
    {'name' => 'qmail-toaster', 'version' => '1.03-1.3.22'},
    {'name' => 'courier-authlib-toaster', 'version' => '0.59.2-1.3.10'},
    {'name' => 'courier-imap-toaster', 'version' => '4.1.2-1.3.10'},
    {'name' => 'autorespond-toaster', 'version' => '2.0.5-1.4.0'},
    {'name' => 'ezmlm-toaster', 'version' => '0.53.324-1.3.6'},
    {'name' => 'maildrop-toaster', 'version' => '2.0.3-1.3.8'},
    {'name' => 'spamassassin-toaster', 'version' => '3.3.2-1.4.3'},
    {'name' => 'clamav-toaster', 'version' => '0.97.6-1.4.2'},
    {'name' => 'ripmime-toaster', 'version' => '1.4.0.6-1.3.6'},
    {'name' => 'simscan-toaster', 'version' => '1.4.0-1.4.0'},
]

default['qmailtoaster']['packages']['frontend']['sources'] = [
    {'name' => 'control-panel-toaster', 'version' => '0.5-1.4.0', 'arch' => 'noarch'},
    {'name' => 'qmailadmin-toaster', 'version' => '1.2.16-1.4.0'},
    {'name' => 'qmailmrtg-toaster', 'version' => '4.2-1.3.7'},
    {'name' => 'isoqlog-toaster', 'version' => '2.1-1.3.7'},
    # vqadmin-toaster does not install cleanly yet
    # { 'name' => 'vqadmin-toaster', 'version' => '2.3.7-1.4.1' },
]
