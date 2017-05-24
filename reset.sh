#!/bin/bash
source env.sh
cf target -o $ORG
cf target -s space1
cf delete-service registry1 -f
cf target -s space2
cf delete-service registry2 -f
