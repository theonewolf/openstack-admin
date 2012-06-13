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
printf 'Set environment variables accordingly:\n
SERVICE_TOKEN\nOS_TENANT_NAME\nOS_USERNAME\nOS_PASSWORD\nOS_AUTH_URL\n
SERVICE_ENDPOINT\n'
printf '\nTest setup with "glance index"'
