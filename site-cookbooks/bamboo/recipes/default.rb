#
# Cookbook Name:: bamboo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bamboo_parent = node['bamboo']['bamboo_home']
bamboo_user = node['bamboo']['bamboo_user']
tarball_name = node['bamboo']['name']

include_recipe "java::default"

user bamboo_user do
system true
action :create
end

group bamboo_user do
members bamboo_user
end


directory bamboo_parent do
group bamboo_user
owner bamboo_user
recursive true
mode "0755"
action :create
end

remote_file "/tmp/#{tarball_name}.tar.gz" do
source node['bamboo']['dl_url']
end

bash "get_files" do
 code <<-EOH
 cd /tmp
 tar xvzf #{tarball_name}.tar.gz -C #{bamboo_parent}
 chown -R bamboo:bamboo #{bamboo_parent}/#{tarball_name}
 EOH
 not_if "test -d #{bamboo_parent}/#{tarball_name}"
 end

directory "#{bamboo_parent}/#{tarball_name}" do
group bamboo_user
owner bamboo_user
recursive true
mode "0755"
end

cookbook_file "bamboo" do
path "/etc/init.d/bamboo"
mode "0755"
group bamboo_user
owner bamboo_user
action :create_if_missing
notifies :restart, "service[bamboo]", :immediately
end

execute "add_chkconfig" do
command "chkconfig --add bamboo"
end

cookbook_file "bamboo-init.properties" do
path "#{bamboo_parent}/#{tarball_name}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties"
mode "0644"
group bamboo_user
owner bamboo_user
action :create
notifies :restart, "service[bamboo]", :immediately
end

 service "bamboo" do
 action [ :enable, :start ]
 end

service "iptables" do
 action :stop
end
 
