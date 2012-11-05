action :install do
  directory "#{node["qmailtoaster"]["workspace"]}/SRPMS" do
    recursive true
  end
  Chef::Log.info("Compiling #{new_resource.name} at version #{new_resource.version} #{node["qmailtoaster"]["rpmbuild"]["distro"]}")
  remote_file "#{node["qmailtoaster"]["workspace"]}/SRPMS/#{new_resource.name}-#{new_resource.version}.src.rpm" do
    source "http://mirrors.qmailtoaster.com/current/SRPMS/#{new_resource.name}-#{new_resource.version}.src.rpm"
    mode 640
    not_if { ::File.exists?("#{node["qmailtoaster"]["workspace"]}/SRPMS/#{new_resource.name}-#{new_resource.version}.src.rpm") }
  end
  execute "build_#{new_resource.name}" do
    command "rpmbuild --rebuild --with cnt50#{node["qmailtoaster"]["rpmbuild"]["distro"]} #{node["qmailtoaster"]["workspace"]}/SRPMS/#{new_resource.name}-#{new_resource.version}.src.rpm"
    not_if "rpm -qi #{new_resource.name}"
  end

  # Install it
  package new_resource.name do
    action :upgrade
    source "#{node["qmailtoaster"]["workspace"]}/RPMS/#{new_resource.arch}/#{new_resource.name}-#{new_resource.version}.#{new_resource.arch}.rpm"
    provider Chef::Provider::Package::Rpm
    not_if "rpm -qi #{new_resource.name}"
  end
end