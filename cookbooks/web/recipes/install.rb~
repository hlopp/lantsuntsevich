include_recipe "php::#{node['web']['web_server_type']}"

web "server" do
	provider "#{node[:web_server_type]}"
	action :install_server
end
