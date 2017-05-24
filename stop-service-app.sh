#!/bin/bash 
source env.sh
cf target -o $ORG 
cf target -s space2
regid=`cf service registry2|grep Dashboard|cut -d "/" -f6|sed "s/ //g"`
cf target -o p-spring-cloud-services -s instances > /dev/null
cf stop eureka-$regid


