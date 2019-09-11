[![Build Status](https://travis-ci.org/opendatacube/dea-index.svg?branch=master)](https://travis-ci.org/opendatacube/dea-index)

DEA-INDEX
==========
This docker is pre-loaded with dea products for example:
```
landsat-geomedian
WOfS summary
WOfS Annual Summary
Barest Earth
```
We will continue to add more products  as we go along.

To access a docker image with pre loaded datasets run:

```
docker-compose up -d 
```
under `dea-index` repository, this will spin up 2 docker containers with container name as:

* dea_index_postgres
* dea_index_wms

`dea_index_postgres` is the postgres docker image that is loaded with indexed products and `dea_index_wms` is connected to the postgres image where you can access the database, list and load the products.

To access the datasets, run :

```
docker exec -t -i dea_index_wms /bin/bash
```
and list/load the products using `datacube` commands. To list the datacube indexed product run:

```
datacube product list
```

can view all the preloaded products in datacube.

### Index New Products

In order to add more datasets to this exiting database you need to modify the file under `dea-index/docker/docker-compose.yaml` under this section

```yaml

      - PRODUCT_URLS=https://raw.githubusercontent.com/GeoscienceAustralia/dea-config/master/dev/products/wofs/wofs_annual_summary.yaml
      - DC_S3_INDEX_BUCKET=dea-public-data
      - DC_S3_INDEX_PREFIX=WOfS/annual_summary/v2.1.5/combined/*/*/*.yaml
      - DC_S3_INDEX_SUFFIX=.yaml
      - DC_INDEX_YAML_SAFETY=SAFE
      #- DC_RANGES_PRODUCT=high_tide_comp_20p low_tide_comp_20p ls8_barest_earth_albers
      - DC_IGNORE_LINEAGE=TRUE
      - DC_INDEX_PROTOCOL=s3
      # AWS Configuration will be read from the local env var
      - AWS_ACCESS_KEY_ID
      - AWS_SECRET_ACCESS_KEY
      - AWS_DEFAULT_REGION=ap-southeast-2
      - AWS_METADATA_SERVICE_TIMEOUT=60
      - AWS_METADATA_SERVICE_NUM_ATTEMPTS=30
```
1. Most of the existing products resides in <https://github.com/GeoscienceAustralia/dea-config/tree/master/dev/products> otherwise add your own products.
   Add the raw product definition to `PRODUCT_URL` 
2. `DC_S3_INDEX_BUCKET` you can set which bucket to index from
3. Set the Path of the bucket object in where the datacube datasets yaml live to `DC_S3_INDEX_PREFIX`

and run the `build.sh` to begin indexing 

Note:
You need to import your AWS credential keys to the local shell env before you run the build script.

Please do not add any credentials to the above yaml file and git commit.

If the product is indexed without any errors can be created a PR to merge the newly added product to database to the existing docker in `latest` tag.




