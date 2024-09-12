#!/bin/bash

set -a; source .env; set +a

# reset dict.sql
echo -n "" > dict.sql

# generate inserts
for DICT in `ls dict/*.txt.gz`
do
    # word count of dict
    WC=$(zcat $DICT | wc -l)
    
    # md5 of gz dict
    MD5=`md5sum < $DICT`
    MD5="${MD5:0:32}"
    
    echo "INSERT INTO dicts (dpath, dhash, dname, wcount, hits) VALUES ('$PUBLIC_URL/$DICT', X'$MD5', '${DICT%.txt.gz}', $WC, 0);" | tee -a dict.sql
done