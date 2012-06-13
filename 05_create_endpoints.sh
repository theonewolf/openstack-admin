#!/bin/bash

### GET ID'S ###
printf '\n\n----- Provide Identifiers -----\n\n'

read -p 'Admin User ID: ' admin_user_id
read -p 'Nova User ID: ' nova_user_id
read -p 'Glance User ID: ' glance_user_id

read -p 'Admin Role ID: ' admin_role_id
read -p 'Member Role ID: ' member_role_id

read -p 'Admin Tenant ID: ' admin_tenant_id
read -p 'Service Tenant ID: ' service_tenant_id



### ADD ROLES TO USERS IN TENANTS ###
printf '\n\n----- Adding Roles to Users in Tenants -----\n\n'

keystone user-role-add --user $admin_user_id --role $admin_role_id \
                       --tenant_id $admin_tenant_id


keystone user-role-add --user $nova_user_id --role $admin_role_id \
                       --tenant_id $service_tenant_id
keystone user-role-add --user $glance_user_id --role $admin_role_id \
                       --tenant_id $service_tenant_id

keystone user-role-add --user $admin_user_id --role $member_role_id \
                       --tenant_id $admin_tenant_id



### CREATING SERVICES ###
printf '\n\n----- Creating Services -----\n\n'

keystone service-create --name nova --type compute --description \
    'OpenStack Compute Service'
keystone service-create --name volume --type volume --description \
    'OpenStack Volume Service'
keystone service-create --name glance --type image --description \
    'OpenStack Image Service'
keystone service-create --name keystone --type identity --description \
    'OpenStack Identity Service'
keystone service-create --name ec2 --type ec2 --description \
    'EC2 Service'



### LISTING SERVICES ###
printf '\n\n----- Listing Services -----\n\n'

keystone service-list



### CREATING ENDPOINTS ###

read -p 'Region Name: ' region_name
read -p 'Endpoints Hostname (Cloud Controller): ' host_name
read -p 'Nova Compute Service ID: ' nova_compute_service_id
read -p 'Nova Volume Service ID: ' nova_volume_service_id
read -p 'Glance Service ID: ' glance_service_id
read -p 'Keystone Service ID: ' keystone_service_id
read -p 'EC2 Service ID: ' ec2_service_id

keystone endpoint-create \
    --region $region_name \
    --service_id $nova_compute_service_id \
    --publicurl "http://$host_name:8774/v2/\$(tenant_id)s" \
    --adminurl "http://$host_name:8774/v2/\$(tenant_id)s" \
    --internalurl "http://$host_name:8774/v2/\$(tenant_id)s"

keystone endpoint-create \
    --region $region_name \
    --service_id $nova_volume_service_id \
    --publicurl "http://$host_name:8776/v1/\$(tenant_id)s" \
    --adminurl "http://$host_name:8776/v1/\$(tenant_id)s" \
    --internalurl "http://$host_name:8776/v1/\$(tenant_id)s"

keystone endpoint-create \
    --region $region_name \
    --service_id $glance_service_id \
    --publicurl "http://$host_name:9292/v1" \
    --adminurl "http://$host_name:9292/v1" \
    --internalurl "http://$host_name:9292/v1"

keystone endpoint-create \
    --region $region_name \
    --service_id $keystone_service_id \
    --publicurl "http://$host_name:5000/v2.0" \
    --adminurl "http://$host_name:35357/v2.0" \
    --internalurl "http://$host_name:5000/v2.0"

keystone endpoint-create \
    --region $region_name \
    --service_id $ec2_service_id \
    --publicurl "http://$host_name:8773/services/Cloud" \
    --adminurl "http://$host_name:8773/services/Admin" \
    --internalurl "http://$host_name:8773/services/Cloud"

