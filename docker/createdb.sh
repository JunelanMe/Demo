#!/bin/bash

BTICK='`'
EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`

Q1="CREATE DATABASE IF NOT EXISTS ${BTICK}$1${BTICK} CHARACTER SET utf8 COLLATE utf8_general_ci;"
Q2="GRANT ALL ON ${BTICK}$1${BTICK}.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

echo "Attempting to create database: " $SQL

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

$MYSQL -uroot -e "$SQL"
