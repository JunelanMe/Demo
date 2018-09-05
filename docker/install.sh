#!/bin/bash
 yum install puppet
 puppet apply -v --modulepath=./puppet/modules ./puppet/demo.pp
 mysqladmin -u root password "rootxx"
 sh createdb.sh wp wp wp
 #mysqladmin -u root password oldpass "newpass"

 cd /opt	
 wget http://wordpress.org/latest.tar.gz
 tar -xzvf latest.tar.gz 

 #3 
 cd /opt/wordpress
 cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/wp/g" wp-config.php
sed -i "s/username_here/wp/g" wp-config.php
sed -i "s/password_here/wp/g" wp-config.php

sed -i  "s#/project/webapp/basic/web/#/opt/wordpress/#g" vhost-local.conf