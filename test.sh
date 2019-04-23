#!/bin/bash

docker-compose up -d

docker exec -ti dea-index_wms_1 /bin/bash -c "datacube system check" | grep -q YES

if [ $? -eq 0 ]; then
    echo VALID Connection: YES
else
    echo VALID Connection: NO
fi

docker exec -ti  dea-index_wms_1 /bin/bash -c "datacube product list" |grep -q id

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi


docker-compose down
