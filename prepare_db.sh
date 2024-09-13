#!/bin/bash

cat dwpa/db/wpa.sql > db.sql
echo "" >> db.sql
cat dwpa/db/wpa-data.sql >> db.sql
echo "" >> db.sql
if [ -f dict.sql ]; then
    cat dict.sql >> db.sql
fi


echo "Done"