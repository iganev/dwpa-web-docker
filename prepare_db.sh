#!/bin/bash

cat dwpa/db/wpa.sql > db.sql
echo "" >> db.sql
cat dwpa/db/wpa-data.sql >> db.sql

echo "Done"