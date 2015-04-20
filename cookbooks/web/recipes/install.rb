include_recipe "web::#{node['web']['web_server_type']}"

web "server" do
	provider "#{node[:web_server_type]}"
	action :install
end


