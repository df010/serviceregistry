#!/bin/bash 
source env.sh
find . -type d -depth 1|xargs -I % bash -c "cd %;  mvn clean package -DskipTests=true; cd .."
cf target -o $ORG -s space1

cf push -f client/manifest.yml
cf push -f service1/manifest.yml
cf target -s space2
cf push -f service2/manifest.yml
