#!/bin/bash

sed -e "s/LIVY_HOST/${LIVY_HOST}/" /home/jovyan/.sparkmagic/config_template.json | sed -e "s/LIVY_PORT/${LIVY_PORT}/"  > /home/jovyan/.sparkmagic/config.json

jupyter notebook --ip=0.0.0.0 --NotebookApp.iopub_data_rate_limit=1000000000  --NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$aULytf4JTcui91foDL7XvA$e2Wxp1eBba+J4LWigbpmsQ'
