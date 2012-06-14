#!/bin/bash

### CREATE TENANTS ###
printf '\n\n----- Creating Tenants -----\n\n'
keystone tenant-create --name admin
keystone tenant-create --name service



### CREATE USERS ###
printf '\n\n----- Creating Users -----\n\n'
read -p 'Admin pass: ' admin_pass
read -p 'Admin email: ' admin_email
read -p 'Nova pass: ' nova_pass
read -p 'Nova email: ' nova_email
read -p 'Glance pass: ' glance_pass
read -p 'Glance email: ' glance_email

keystone user-create --name admin --pass $admin_pass --email $admin_email
keystone user-create --name nova --pass $nova_pass --email $nova_email
keystone user-create --name glance --pass $glance_pass --email $glance_email

unset admin_pass
unset admin_email
unset nova_pass
unset nova_email
unset glance_pass
unset glance_email



### CREATE ROLES ###
printf '\n\n----- Creating Roles -----\n\n'
keystone role-create --name admin
keystone role-create --name Member



### LISTING ###
printf '\n\n----- Listing -----\n\n'
printf 'Tenants\n\n'
keystone tenant-list

printf '\n\nUsers\n\n'
keystone user-list

printf '\n\nRoles\n\n'
keystone role-list
