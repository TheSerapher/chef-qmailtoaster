require 'chefspec'

describe 'qmailtoaster::_install_dependencies_backend' do
  before (:all) {
      @chef_run = ChefSpec::ChefRunner.new
      @chef_run.node.set["mysql"] = { "server_root_password" => "root", "server_debian_password" => "debian", "server_repl_password" => "repl" }
      @chef_run.converge 'qmailtoaster::_install_dependencies_backend'
  }
  %w{ build-essential mysql mysql::server }.each do |recipe|
    it "should include the #{recipe} cookbook" do
      @chef_run.should include_recipe recipe
    end
  end
  %w{
    rpm-build kernel-devel compat-libf2c-34 compat-libstdc++-33 bzip2 bzip2-devel bzip2-libs compat-gcc-34
    compat-gcc-34-c++ compat-glibc compat-glibc-headers curl libcurl-devel expect
    expect-devel gdbm gdbm-devel gmp gmp-devel groff httpd-devel httpd-manual krb5-auth-dialog
    krb5-devel krb5-libs krb5-workstation libgcc libidn libidn-devel libtool libtool-ltdl libtool-ltdl-devel
    mysql-bench openssl-devel pcre-devel procmail ruby-mysql
    perl-libwww-perl perl-Archive-Tar perl-Digest-HMAC perl-Digest-SHA1 perl-HTML-Parser perl-Net-DNS perl-Time-HiRes
    perl-Mail-SPF-Query perl-ExtUtils-MakeMaker perl-NetAddr-IP
    sed setup stunnel system-config-date wget which zlib zlib-devel ncurses-devel
    redhat-rpm-config rpm-build rpm-devel rpm-libs rpm-python
  }.each do |pkg|
    it "should install package #{pkg}" do
      @chef_run.should install_package pkg
    end
  end
end
