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
  Chef::Log.info("Compiling #{new_resource.name} with #{rpmbuild_opts} " +
                 "at version #{new_resource.version}")
  remote_file "#{node['qmailtoaster']['workspace']}/SRPMS/" +
              "#{new_resource.name}-#{new_resource.version}.src.rpm" do
    source 'http://mirrors.qmailtoaster.com/current/SRPMS/' +
           "#{new_resource.name}-#{new_resource.version}.src.rpm"
    mode '640'
    not_if do
      "test -f #{node['qmailtoaster']['workspace']}/SRPMS/" +
        "#{new_resource.name}-#{new_resource.version}.src.rpm"
    end
  end
  r = execute "build_#{new_resource.name}" do
    command "rpmbuild --rebuild #{rpmbuild_opts} #{node['qmailtoaster']['workspace']}/SRPMS/" +
            "#{new_resource.name}-#{new_resource.version}.src.rpm"
    not_if "rpm -qi #{new_resource.name}"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
  # Install it
  r = package new_resource.name do
    action :install
    source "#{node['qmailtoaster']['workspace']}/RPMS/#{new_resource.arch}/" +
           "#{new_resource.name}-#{new_resource.version}.#{new_resource.arch}.rpm"
    provider Chef::Provider::Package::Rpm
    not_if "rpm -qi #{new_resource.name}"
  end
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
