# -----------------------------------------------------------------------------
# Copies Jenkins configuration
# -----------------------------------------------------------------------------
cookbook_file "#{node['jenkins']['master']['home']}/jenkins.yaml" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode  '0644'
  source "var/lib/jenkins/jenkins.yaml"
end

# -----------------------------------------------------------------------------
# Installs JCasC related plugins
# -----------------------------------------------------------------------------
%w(configuration-as-code=1.4 configuration-as-code-support=1.4 ssh-credentials=1.14 credentials=2.1.18 structs=1.17).each do |plugin|
  plugin, version = plugin.split('=')
  remote_file "#{node['jenkins']['master']['home']}/plugins/#{plugin}.hpi" do
    source "http://updates.jenkins-ci.org/download/plugins/#{plugin}/#{version}/#{plugin}.hpi"
    owner 'jenkins'
    group 'jenkins'
    mode '755'
  end
end

service "jenkins" do
  action :restart
end
