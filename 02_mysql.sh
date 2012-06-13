#!/bin/bash


# helper functions

function init()
{
    sudo apt-get install mysql-server python-mysqldb
    read -s -p 'Root MySQL Password: ' mysql_pass
}

function cleanup()
{
    unset mysql_pass
}

function db_setup()
{
    mysql --user=root --password=$mysql_pass --execute="CREATE DATABASE $1;"

    mysql --user=root --password=$mysql_pass --execute="GRANT ALL PRIVILEGES ON $1.* TO '$2'@'%' IDENTIFIED BY '$3';"

    mysql --user=root --password=$mysql_pass --execute="GRANT ALL PRIVILEGES ON $1.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
}



### MAIN ###
init 



### NOVA CREATE ###
printf '\n\n----- Creating nova db -----\n\n'
read -p 'nova db name: ' nova_db
read -p 'nova user: ' nova_user
read -p 'nova db pass: ' nova_pass
db_setup $nova_db $nova_user $nova_pass
unset nova_db
unset nova_user
unset nova_pass



### GLANCE CREATE ###
printf '\n\n----- Creating glance db -----\n\n'
read -p 'glance db name: ' glance_db
read -p 'glance user: ' glance_user
read -p 'glance db pass: ' glance_pass
db_setup $glance_db $glance_user $glance_pass
unset glance_db
unset glance_user
unset glance_pass



### KEYSTONE CREATE ###
printf '\n\n----- Creating keystone db -----\n\n'
read -p 'keystone db name: ' keystone_db
read -p 'keystone user: ' keystone_user
read -p 'keystone db pass: ' keystone_pass
db_setup $keystone_db $keystone_user $keystone_pass
unset keystone_db
unset keystone_user
unset keystone_pass
