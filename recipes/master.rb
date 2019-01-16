include_recipe 'java::default'
include_recipe 'jenkins::master'

# It has to be included after jenkins::master
edit_resource!(:template, '/etc/sysconfig/jenkins') do
  source 'jenkins-config-rhel.erb'
  cookbook 'acme-jenkins'
end

# -----------------------------------------------------------------------------
# Jenkins User
# -----------------------------------------------------------------------------
user 'jenkins' do
  shell '/bin/bash'

  action :modify
end

# -----------------------------------------------------------------------------
# Dot files
# -----------------------------------------------------------------------------
%w(bashrc bash_profile).each do |file|
  cookbook_file "#{node['jenkins']['master']['home']}/.#{file}" do
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode  '0644'
    source "var/lib/jenkins/#{file}"
  end
end

# -----------------------------------------------------------------------------
# SSH keys and configuration
# -----------------------------------------------------------------------------
execute 'Generate SSH key for Jenkins' do
  user node['jenkins']['master']['user']
  command 'ssh-keygen '\
    '-t rsa '\
    '-b 8192 '\
    '-q '\
    "-f #{node['jenkins']['master']['home']}/.ssh/id_rsa "\
    "-P ''"

  not_if { ::File.exist?("#{node['jenkins']['master']['home']}/.ssh/id_rsa") }
end
