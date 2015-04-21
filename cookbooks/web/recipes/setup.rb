provider_name = "web_"+node['web']['web_server_type']

web "server" do
	provider "#{provider_name}"
	action :setup_web_server
end


