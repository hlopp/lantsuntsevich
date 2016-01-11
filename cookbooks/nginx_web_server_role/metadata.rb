name "nginx_web_server_role"
maintainer       'EPAM Lab'
maintainer_email 'Natallia_Lantsuntsevich@epam.com'
license          'All rights reserved'
description "Run-list for nginx role"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.1.0"
depends "web"

