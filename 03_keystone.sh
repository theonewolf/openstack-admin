#!/bin/bash

sudo apt-get install keystone python-keystone python-keystoneclient

printf '\n\nSetup the admin_token and connection variable'
printf 'Press enter when ready to edit keystone.conf\n'
printf 'Random token: %s' `head -c 1024 /dev/urandom | base64 | head -c 64`
read
sudo vim /etc/keystone/keystone.conf

sudo service keystone restart
sudo keystone-manage db_sync

export SERVICE_ENDPOINT='http://localhost:35357/v2.0'
read -s -p 'admin_token: ' SERVICE_TOKEN
export SERVICE_TOKEN

printf '\n\nDropping to a bash with SERVICE_ENDPOINT and SERVICE_TOKEN 
set.\n\n'

bash
