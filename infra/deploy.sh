#!/bin/bash

openstack network create pizzaria
openstack subnet create --network pizzaria --subnet-range 10.0.2.0/24 nightwatch
openstack subnet create --network pizzaria --subnet-range 10.0.3.0/24 cloud

openstack router create cawthon --external-gateway external249
openstack router add subnet cawthon nightwatch
openstack router add subnet cawthon cloud

NETID=$(openstack network list -f value | grep pizzaria -w | awk '{print $1}')

openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.2.10 --security-group default west_hall
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.2.11 --security-group default east_hall
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.2.14 --security-group default hm_pirate_cove
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.3.10 --security-group default dining_area
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.3.11 --security-group default kitchen

openstack server create --flavor medium --image WinSrv2016-14393-2022 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.2.12 --security-group default backstage
openstack server create --flavor medium --image Win10-1809v2 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.2.13 --security-group default show_stage
openstack server create --flavor medium --image WinSrv2016-14393-2022 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.3.12 --security-group default supply_closet

openstack network create pizzaria2
openstack subnet create --network pizzaria2 --subnet-range 10.0.4.0/24 nightwatch2
openstack subnet create --network pizzaria2 --subnet-range 10.0.5.0/24 cloud2

openstack router add subnet cawthon nightwatch2
openstack router add subnet cawthon cloud2

NETID=$(openstack network list -f value | grep pizzaria2 -w | awk '{print $1}')

openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.4.10 --security-group default west_hall
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.4.11 --security-group default east_hall
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.4.14 --security-group default hm_pirate_cove
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.5.10 --security-group default dining_area
openstack server create --flavor medium --image UbuntuJammy2204-Desktop --key-name GreyTeamJumpBoxKey --nic net-id=$NETID,v4-fixed-ip=10.0.5.11 --security-group default kitchen

openstack server create --flavor medium --image WinSrv2016-14393-2022 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.4.12 --security-group default backstage
openstack server create --flavor medium --image Win10-1809v2 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.4.13 --security-group default show_stage
openstack server create --flavor medium --image WinSrv2016-14393-2022 --key-name GreyTeamJumpBoxKey --user-data prepare-for-ansible-windows.ps1 --nic net-id=$NETID,v4-fixed-ip=10.0.5.12 --security-group default supply_closet
