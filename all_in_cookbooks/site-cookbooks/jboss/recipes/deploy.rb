#
# Cookbook Name:: jboss
# Recipe:: default
#

#
# license Apache v2.0
#


# Install the unzip package
package "unzip" do
  action :install
end

jboss_home = node['jboss']['deploy_dir']
jboss_user = node['jboss']['jboss_user']

tarball_name = node['jboss']['deploy_url'].
  split('/')[-1].
  sub!('.zip', '')
path_arr = jboss_home.split('/')
path_arr.delete_at(-1)
jboss_parent = path_arr.join('/')


#bash "tarball name" do
#	code <<-EOH
#    "echo '#{tarball_name}'"
#    EOH
#end

# get files
bash "put_files" do
  code <<-EOH
  cd /tmp
  wget #{node['jboss']['deploy_url']}
  
  unzip #{tarball_name}.zip -d #{jboss_home}
  chown -R jboss:jboss #{jboss_home}
  rm -f #{tarball_name}.zip
  EOH
#  not_if "test -d #{jboss_home}"
end

#directory "#{jboss_home}" do
#  owner 'jboss'
#  group 'jboss'
#  mode '0755'
#  recursive true
#end

