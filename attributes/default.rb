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
    { 'name' => 'daemontools-toaster', 'version' => '0.76-1.3.6', 'checksum' => '4442afb3758891b47202c7314abed47c594f988e44a50c8180137507c512bce9' },
    { 'name' => 'ucspi-tcp-toaster', 'version' => '0.88-1.3.9', 'checksum' => 'fb27eb92a3d6cbf393044a67ae3f74d335abf223197bde1e98a350acb5e582ba' },
    { 'name' => 'vpopmail-toaster', 'version' => '5.4.33-1.4.0', 'checksum' => '1b3c268786f48189867125ab4f0461bb7bdac2e4621bd76761fecd91e86f2178' },
    { 'name' => 'libdomainkeys-toaster', 'version' => '0.68-1.3.6', 'checksum' => '93847c07701db0f84a2b9c2a677001d4c4678cc3a9714d4480423bbd8f6e5619' },
    { 'name' => 'libsrs2-toaster', 'version' => '1.0.18-1.3.6', 'checksum' => '948a0cfc45398107ab5496412b7942b453b260515cd8365fbb1edefefe81fd26' },
    { 'name' => 'qmail-toaster', 'version' => '1.03-1.3.22', 'checksum' => 'f5998e47813bb57c7dd921b8ef11a817b02921af16a8751bf9df233344660fe4' },
    { 'name' => 'courier-authlib-toaster', 'version' => '0.59.2-1.3.10', 'checksum' => 'bb88815f8063fbba985ba2831993ebb98cea89b93d93cf5e366409d355a37f07' },
    { 'name' => 'courier-imap-toaster', 'version' => '4.1.2-1.3.10', 'checksum' => '90a86d7d99db2d865af0654db39f5cc409b580f14277b15cec2deb489993093a' },
    { 'name' => 'autorespond-toaster', 'version' => '2.0.5-1.4.0', 'checksum' => 'f1327165b40ad95c43b192c614e95002a157b57bf9e6fcfa456f6609bdc45103' },
    { 'name' => 'ezmlm-toaster', 'version' => '0.53.324-1.3.6', 'checksum' => '875bc452e0268b86bf32e941a6f373c59653d921b8fcc3442829ab62a1bc3474' },
    { 'name' => 'maildrop-toaster', 'version' => '2.0.3-1.3.8', 'checksum' => 'a44c716131ce3ec70607c83708a0dcb6e242e7e111f0bb8333f5eff4de8d1c60' },
    { 'name' => 'spamassassin-toaster', 'version' => '3.3.2-1.4.3', 'checksum' => '9085a0be51766f5769405819bc21202b1801a8a30973289877f2ce2df08a8bc9' },
    { 'name' => 'clamav-toaster', 'version' => '0.97.8-1.4.4', 'checksum' => '034b185d44d76c367c28871f29348e176ab1b8150e25f5deb5933d205f09ef1c' },
    { 'name' => 'ripmime-toaster', 'version' => '1.4.0.6-1.3.6', 'checksum' => '6bd8d7d6f97d5302137896b4d20308a33fca657c8acd2f874bb2cba02c7ec73d' },
    { 'name' => 'simscan-toaster', 'version' => '1.4.0-1.4.0', 'checksum' => '2a1f176c42c242e0368420d0f93cfca889f407fff6603a3ac251cf311e01b0e8' }
]

default['qmailtoaster']['packages']['frontend']['sources'] = [
    { 'name' => 'control-panel-toaster', 'version' => '0.5-1.4.0', 'arch' => 'noarch' },
    { 'name' => 'qmailadmin-toaster', 'version' => '1.2.16-1.4.1' },
    { 'name' => 'qmailmrtg-toaster', 'version' => '4.2-1.3.7' },
    { 'name' => 'isoqlog-toaster', 'version' => '2.1-1.3.7' },
    # vqadmin-toaster does not install cleanly yet
    # { 'name' => 'vqadmin-toaster', 'version' => '2.3.7-1.4.1' },
]

# Ensure build essential is installed first
set['build_essential']['compiletime'] = true
