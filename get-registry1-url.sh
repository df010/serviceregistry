#!/bin/bash 
source env.sh
cf target -o $ORG 
cf target -s space1
regid=`cf service registry1|grep Dashboard|cut -d "/" -f6|sed "s/ //g"`
cf target -o p-spring-cloud-services -s instances > /dev/null
cf app eureka-$regid|grep urls
