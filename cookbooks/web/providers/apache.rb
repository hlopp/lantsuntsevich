#provider

provides :web

use_inline_resources

def whyrun_supported?
  true
end

action :install do
  Chef::Log.info("Installing apache2")
  package "apache2" do
      action :install
  end
end

action :setup_web_server do
  Chef::Log.info("Setup action for apache2")
  template node['web']['config_path'] do
    name node['web']['config_path']
  	source "apache_httpd.conf.erb"
  	variables(
  	  :port => node['web']['server_port'],
  	  :interface => node['web']['server_interface']
      )
	end
end

action :stop do
  Chef::Log.info("Stopping apache2")
  service "apache2" do
      action :stop
  end
end

action :start do
    Chef::Log.info("Starting apache2")
    service "apache2" do
        supports :status => true, :restart => true, :reload => true
        action :start
    end
end

action :restart do
    Chef::Log.info("Restarting apache2")
    service "apache2" do
        action :restart
    end
end

action :reload do
    Chef::Log.info("Reloading apache2 config")
    service "apache2" do
        action :reload
    end
end
