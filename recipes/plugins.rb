updatesUrl = 'http://updates.jenkins-ci.org/download/plugins'

# Configuration as code
%w(configuration-as-code=1.4 configuration-as-code-support=1.4 ssh-credentials=1.14 credentials=2.1.18 structs=1.17).each do |plugin|
  plugin, version = plugin.split('=')
  remote_file "#{node['jenkins']['master']['home']}/plugins/#{plugin}.hpi" do
    source "#{updatesUrl}/#{plugin}/#{version}/#{plugin}.hpi"
    owner 'jenkins'
    group 'jenkins'
    mode '755'
  end
end


cookbook_file "#{node['jenkins']['master']['home']}/jenkins.yml" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode  '0644'
  source "var/lib/jenkins/jenkins.yml"
end

%w(profile bashrc).each do |file|
  cookbook_file "#{node['jenkins']['master']['home']}/.#{file}" do
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode  '0644'
    source "var/lib/jenkins/#{file}"
  end
end

service "jenkins" do
  action :restart
end
