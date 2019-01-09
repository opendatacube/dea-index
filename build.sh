#!/bin/bash

# Build template 
cd docker 

# get the latest config
pushd config
wget https://raw.githubusercontent.com/GeoscienceAustralia/dea-config/master/dev/services/wms/ows/wms_cfg.py 
popd

# Run the index job
docker-compose up -d

# Wait until the database is loaded

#until docker logs docker_index_1 | grep -m 1 "<sometext>"; do sleep 10; done

# Save the image with built database
docker stop postgres
docker commit postgres opendatacube/dea-index:$(date +%Y-%m-%d)
docker tag opendatacube/dea-index:$(date +%Y-%m-%d) opendatacube/dea-index:latest

# test it out 

# push it up