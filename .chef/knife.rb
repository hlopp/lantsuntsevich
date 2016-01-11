# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "hlopphlopp"
client_key               "#{current_dir}/hlopphlopp.pem"
validation_client_name   "olo-validator"
validation_key           "#{current_dir}/olo-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/olo"
cookbook_path            ["#{current_dir}/../cookbooks"]
role_path                ["#{current_dir}/../roles"]
node_path                ["#{current_dir}/../nodes"]
environment_path         ["#{current_dir}/../environments"]
