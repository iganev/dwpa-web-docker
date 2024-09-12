#!/bin/bash

cat dwpa/db/wpa.sql > db.sql
echo "" >> db.sql
cat dwpa/db/wpa-data.sql >> db.sql
echo "" >> db.sql
if [ -f dicts.sql ]; then
    cat dicts.sql >> db.sql
fi


echo "Done"