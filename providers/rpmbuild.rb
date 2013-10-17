# Encoding: UTF-8
action :install do
  directory "#{new_resource.name}-create-workspace" do
    path "#{node['qmailtoaster']['workspace']}/SRPMS"
    recursive true
  end
  if node['kernel']['machine'] =~ /x86_64/
    rpmbuild_opts = '--with cnt5064'
  else
    rpmbuild_opts = '--with cnt50'
  end
  remote_file "#{node['qmailtoaster']['workspace']}/SRPMS/" +
              "#{new_resource.name}-#{new_resource.version}.src.rpm" do
    source 'http://mirrors.qmailtoaster.com/current/SRPMS/' +
           "#{new_resource.name}-#{new_resource.version}.src.rpm"
    checksum new_resource.checksum if new_resource.checksum
    mode '640'
    notifies :run, "execute[build_#{new_resource.name}]", :immediately
  end
  r = execute "build_#{new_resource.name}" do
    action :nothing
    command "rpmbuild --rebuild #{rpmbuild_opts} #{node['qmailtoaster']['workspace']}/SRPMS/" +
            "#{new_resource.name}-#{new_resource.version}.src.rpm"
    notifies :install, "package[#{new_resource.name}]", :immediately
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
  # Install it
  r = package new_resource.name do
    action :nothing
    source "#{node['qmailtoaster']['workspace']}/RPMS/#{new_resource.arch}/" +
           "#{new_resource.name}-#{new_resource.version}.#{new_resource.arch}.rpm"
    provider Chef::Provider::Package::Rpm
    not_if "rpm -qi #{new_resource.name}"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
