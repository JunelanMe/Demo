#!/bin/bash

function echoGreen(){   echo -e "\033[42;34m ------------------> PASS $1 \033[0m" }

function echoRed(){     echo -e "\033[41;37m ------------------> ERROR $1 \033[0m" }

function echoYellow(){  echo -e "\033[43;30m ------------------> Warning $1 \033[0m" }

function echoBlue(){    echo -e "\033[46;30m ------------------> STEP $1 \033[0m" }

rpm -qa|grep puppet
if [ $? -eq 0 ]
then
 echoBlue " Puppet not install , install it "
 yum install puppet
fi

 puppet apply -v --modulepath=./puppet/modules ./puppet/demo.pp

 mysql -uroot -prootxx -e "show databases;" |grep wp
 if [ $? -eq 1 ]
 then
    echoBlue " wp databases doest not created , created it "
    sh createdb.sh wp wp wp
 fi 
 
 mysqladmin -u root password "rootxx"
 # mysqladmin -u root -p123456 password abcdef 
 # mysqladmin -u root password oldpass "newpass"

 cd /opt	
 wget http://wordpress.org/latest.tar.gz
 tar -xzvf latest.tar.gz 

 #3 
 cd /opt/wordpress
COUNT=`cat wp-config.php  |grep "'wp'" |wc -l`
if [ $COUNT -ne 3 ]; then
   echoRed " wp-config.php does not config correct , correct it  "
   cp wp-config-sample.php wp-config.php

   sed -i "s/database_name_here/wp/g" wp-config.php
   sed -i "s/username_here/wp/g" wp-config.php
   sed -i "s/password_here/wp/g" wp-config.php
fi

sed -i  "s#/project/webapp/basic/web/#/opt/wordpress/#g" vhost-local.conf

#添加防火墙
firewall-cmd --zone=public --query-port=80/tcp
if [ $? -eq 0 ]
then 
   firewall-cmd --zone=public --add-port=80/tcp --permanent
   firewall-cmd --reload
fi 