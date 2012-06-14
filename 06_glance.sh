#!/bin/bash

### INSTALL REQUIRED SOFTWARE ###
sudo apt-get install glance glance-api glance-client glance-common \
                     glance-registry python-glance




### UPDATE CONFIGURATION FILES ###
printf '\n\n----- Update configuration files -----\n\n'

printf '\n\nEdit glance-api-paste.ini setup admin_tenant_name, admin_user,
admin_password.\n\n'
sleep 3
sudo vi /etc/glance/glance-api-paste.ini

printf '\n\nEdit glance-registry-paste.ini setup admin_tenant_name,
admin_user, admin_password.\n\n'
sleep 3
sudo vi /etc/glance/glance-registry-paste.ini

printf '\n\nEdit glance-registry.conf setup sqlconnection and paste_deploy.
\n'
sleep 3
sudo vi /etc/glance/glance-registry.conf

printf '\n\nEdit glance-api.conf setup paste_deploy.
\n'
sleep 3
sudo vi /etc/glance/glance-api.conf



### DB SETUP ###
printf '\n\n----- Setting up database -----\n\n'

sudo glance-manage version_control 0
sudo glance-manage db_sync

sudo restart glance-api
sudo restart glance-registry



### ENVIRONMENT VARIABLE SETUP ###
printf '\n\n----- Testing setup -----\n\n'
read -p 'SERVICE_TOKEN: ' SERVICE_TOKEN
read -p 'OS_TENANT_NAME: ' OS_TENANT_NAME
read -p 'OS_USERNAME' OS_USERNAME
read -p 'OS_PASSWORD: ' OS_PASSWORD
read -p 'OS_AUTH_URL: ' OS_AUTH_URL

glance index

unset SERVICE_TOKEN
unset OS_TENANT_NAME
unset OS_USERNAME
unset OS_PASSWORD
unset OS_AUTH_URL
