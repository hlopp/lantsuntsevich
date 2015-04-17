#
# Cookbook Name:: jboss
# Recipe:: deploy
#

#
# license Apache v2.0
#


# Install the unzip package
=begin
 package "unzip" do
  action :install
end

jboss_home = node['jboss']['deploy_dir']
jboss_user = node['jboss']['jboss_user']

tarball_name = node['jboss_common']['app_repo'].
  split('/')[-1].
  sub!('.zip', '')
path_arr = jboss_home.split('/')
path_arr.delete_at(-1)
jboss_parent = path_arr.join('/')



# get files
#bash "put_files" do
#  code <<-EOH
#  cd /tmp
#  wget #{node['jboss_common']['app_repo']}
#  
#  unzip #{tarball_name}.zip -d #{jboss_home}
#  chown -R jboss:jboss #{jboss_home}
#  rm -f #{tarball_name}.zip
#  EOH
#end
=end
######
#New content

jboss_home = node['jboss']['deploy_dir']
jboss_user = node['jboss']['jboss_user']

# Install the unzip package
package "unzip" do
  action :install
end

#Clean From previous try
directory "/tmp/repo_tmp" do
  recursive true
  action :delete
end

#create temp dir for file download
directory "/tmp/repo_tmp" do
  owner 'jboss'
  group 'jboss'
  mode '0755'
  action :create
end

#get archive name
tarball_name = node['jboss_common']['app_repo'].
  split('/')[-1].
  sub!('.zip', '')
#path_arr = jboss_home.split('/')
#path_arr.delete_at(-1)
#jboss_parent = path_arr.join('/')

#get file from repo
remote_file "download from repo" do 
  path "/tmp/repo_tmp/#{tarball_name}.zip" 
  source node['jboss_common']['app_repo']
  owner 'jboss'
  group 'jboss'
  mode 0755
  action :create
end


#unpack archive
execute "unpack_zip" do
  command "unzip -o /tmp/repo_tmp/#{tarball_name}.zip -d /tmp/repo_tmp/"
#  not_if { ::File.exists?("/tmp/repo_tmp/#{tarball_name}.zip")}
  action :run
end

#delete source archive
file "/tmp/repo_tmp/#{tarball_name}.zip" do
  action :delete
end


app_config_dataitem = search(:jboss_data, "id:app_config_filename").first
app_config_filename = app_config_dataitem["filename"]

#replace unpacked hudson.xml with modified copy from chef server (file picked from files/default)
cookbook_file app_config_filename do
  path "/tmp/repo_tmp/#{tarball_name}/#{app_config_filename}"
  owner 'jboss'
  group 'jboss'
  mode 0755
  action :create
end
#if previous section fails - try following beginning
#cookbook_file "#{app_config_filename}" do

#transferring prepared application to jboss deployments dir
bash "move_prepared_files" do
  code <<-EOH
  mv  /tmp/repo_tmp/* #{jboss_home}
  chown -R jboss:jboss #{jboss_home}
  EOH
end













