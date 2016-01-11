#provider

provides :web

use_inline_resources

def whyrun_supported?
  true
end

action :install do
  Chef::Log.info("Installing nginx")
  package "nginx" do
      action :install
  end
end

action :setup_web_server do
  Chef::Log.info "Setup action for nginx"
  template node['web']['config_path'] do
    name node['web']['config_path']
  	source "nginx.conf.erb"
  	variables(
  	  :port => node['web']['server_port'],
  	  :interface => node['web']['server_interface']
      )
	end
end

action :stop do
  Chef::Log.info "Stopping nginx"
  service "nginx" do
      action :stop
  end
end

action :start do
    Chef::Log.info "Starting nginx"
    service "nginx" do
        supports :status => true, :restart => true, :reload => true
        action :start
    end
end

action :restart do
    Chef::Log.info "Restarting nginx"
    service "nginx" do
        action :restart
    end
end

action :reload do
    Chef::Log.info "Reloading nginx config"
    service "nginx" do
        action :reload
    end
end
