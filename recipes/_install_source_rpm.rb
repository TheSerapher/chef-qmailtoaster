# Include required recipes

node["qmailtoaster"]["packages"]["sources"].each do |data|
  qmailtoaster_rpmbuild data["name"] do
    version data["version"]
  end
end