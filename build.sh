#!/bin/bash

# Build template 
cd docker 

# get the latest config
pushd config
wget https://raw.githubusercontent.com/GeoscienceAustralia/dea-config/master/dev/services/wms/ows/wms_cfg.py -O wms_cfg.py
#wget https://gist.githubusercontent.com/harshurampur/bebb0e718d8090fea0247f37909bd2eb/raw/e183955c8ab7b5a6bcdbc4f8e085928983062499/wms_cfg.py -O wms_cfg.py
popd


# Run the index job
docker-compose up -d

# Wait until the database is loaded

until docker logs docker_index_1 | grep -m 1 "Updating range for:  low_tide_comp_20p"; do sleep 10; done

# Save the image with built database
#docker stop docker_postgres_1
docker commit docker_postgres_1 opendatacube/dea-index:$(date +%Y-%m-%d)
docker tag opendatacube/dea-index:$(date +%Y-%m-%d) opendatacube/dea-index:latest

# test it out 

# push it up
#docker push --disable-content-trust=true opendatacube/dea-index:$(date +%Y-%m-%d) opendatacube/dea-index:latest