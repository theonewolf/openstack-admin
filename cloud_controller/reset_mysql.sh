#!/bin/bash
# Ubuntu 12.04 6/13/2012

sudo apt-get purge mysql-server mysql-server-5.5
sudo rm -rf /var/lib/mysql

sudo apt-get install mysql-server
