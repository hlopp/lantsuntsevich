name "jboss_deploy"
description "Role for deploying app to jboss"
run_list "recipe[jboss::default]","recipe[jboss::deploy]"
