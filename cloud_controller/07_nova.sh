#!/bin/bash

### INSTALL REQUIRED SOFTWARE ###
sudo apt-get install nova-api nova-cert nova-compute nova-network \
                     nova-objectstore nova-scheduler nova-volume  \
                     rabbitmq-server novnc




### EDIT CONF FILES ###
printf '\n\n----- Edit Configuration -----\n\n'

printf '\n\nEdit nova.conf add all necessary options\n'
sleep 3
sudo vi /etc/nova/nova.conf

printf '\n\nEdit api-paste.ini set admin_tenant_name, admin_user,
admin_password.\n'
sleep 3
sudo vi /etc/nova/api-paste.ini


### CREATE LVM STORE ###
read -p 'Physical Device for Volume Storage: ' nova_vol_device

sudo pvcreate $nova_vol_device
sudo vgcreate nova-volumes $nova_vol_device



### SETUP DB ###
printf '\n\n----- Syncing DB ----\n\n'
sudo nova-compute db sync




### SETUP FIRST VIRTUAL NETWORK ###
printf '\n----- Setting first virtual network -----\n'

read -p 'IPv4 Subnet Range: ' ip_subnet
read -p 'Number of Networks: ' num_networks
read -p 'Bridge Type: ' bridge_type
read -p 'Bridge Interface: ' bridge_interface
read -p 'Network Size: ' network_size

sudo nova-manage network create private --fixed_range_v4=$ip_subnet \
                                        --num_networks=$num_networks \
                                        --bridge=$bridge_type \
                                        --bridge_interface=$bridge_interface \
                                        --network_size=$network_size


### SET ENV ###
printf '\n\n----- Get environment configuration -----\n\n'
read -p 'OS_TENANT_NAME: ' OS_TENANT_NAME
read -p 'OS_USERNAME: ' OS_USERNAME
read -p 'OS_PASSWORD: ' OS_PASSWORD
read -p 'OS_AUTH_URL: ' OS_AUTH_URL

export OS_TENANT_NAME
export OS_USERNAME
export OS_PASSWORD
export OS_AUTH_URL



### RESTART ###
printf '\n\n----- Restarting nova services -----\n\n'

sudo restart libvirt-bin
sudo restart nova-network
sudo restart nova-compute
sudo restart nova-api
sudo restart nova-objectstore
sudo restart nova-scheduler
sudo restart nova-volume


### TEST SETUP ###
printf '\n\n----- Testing correctness -----\n\n'

sudo nova-manage service list
