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
