#!/bin/bash 
function wait-service {
  ret=1
  echo -n "waitin"
  while [[ ! "$ret" -eq "0" ]]; do
    sleep 1;
    cf service $1|grep Status|cut -d ":" -f2|grep succeeded;
    ret=$?;
    echo -n "g"
  done;
  echo "g"
}
function service-url {
  regid=`cf service $1|grep Dashboard|cut -d "/" -f6|sed "s/ //g"`
  cf target -o p-spring-cloud-services -s instances > /dev/null
  regurl=`cf app eureka-$regid|grep urls|cut -d":" -f2|sed "s/ //g"`
  echo $regurl
}

source env.sh

cf target -o $ORG 
cf create-space space1
cf target -s space1
cf create-service p-service-registry standard  registry1
wait-service registry1
regurl1=`service-url registry1`


cf target -o $ORG 
cf create-space space2
cf target -s space2
cf create-service p-service-registry standard  registry2 -c "{ \"peers\": [ { \"uri\": \"https://$regurl1\" } ] }"
wait-service registry2
regurl2=`service-url registry2`

cf target -o $ORG -s space1
cf update-service registry1 -c "{ \"peers\": [ { \"uri\": \"https://$regurl2\" } ] }"

wait-service registry1


