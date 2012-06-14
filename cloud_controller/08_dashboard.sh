#!/bin/bash



### INSTALL DASHBOARD ###
printf '\n\n----- Installing Horizon -----\n\n'

sudo apt-get install openstack-dashboard
sudo service apache2 restart
