# Include required recipes
include_recipe "build-essential"
include_recipe "mysql"
include_recipe "mysql::ruby"
include_recipe "mysql::server"
include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "php::module_ldap"

# value_for_platform will work with attributes in Chef 11.0
# http://tickets.opscode.com/browse/CHEF-3499
packages = value_for_platform(
    "centos" => {
        "6.3" => %w{
          libcurl-devel rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33
          aspell bzip2 bzip2-devel bzip2-libs compat-gcc-34 compat-gcc-34-c++ compat-glibc
          compat-glibc-headers curl expect expect-devel gdbm gdbm-devel gmp gmp-devel groff
          httpd-devel httpd-manual krb5-auth-dialog krb5-devel krb5-libs krb5-workstation
          libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel mysql-bench
          mrtg openssl-devel pcre-devel procmail ruby-mysql perl-libwww-perl
          perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser perl-Net-DNS
          perl-Time-HiRes perl-Mail-SPF-Query perl-ExtUtils-MakeMaker perl-NetAddr-IP sed
          setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
          redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python
        },

        "5.8" => %w{
          curl-devel rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 aspell
          bzip2 bzip2-devel bzip2-libs compat-gcc-34 compat-gcc-34-c++ compat-glibc
          compat-glibc-headers curl  expect expect-devel gdbm gdbm-devel gmp gmp-devel
          groff httpd-devel httpd-manual krb5-auth-dialog krb5-devel krb5-libs
          krb5-workstation libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel
          mysql-bench mrtg openssl-devel pcre-devel procmail ruby-mysql
          perl-libwww-perl perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser
          perl-Net-DNS perl-Time-HiRes perl-Mail-SPF-Query perl-NetAddr-IP
          sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
          redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python gnupg
        },
    },
    "default" => ""
)

packages.each do |pkg|
  package pkg
end
