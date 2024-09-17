#!/bin/bash

set -a; source .env; set +a

# Copy base SQL schema
cp dwpa/db/wpa.sql db.sql

# Append wpa-data.sql
echo "" >> db.sql
cat dwpa/db/wpa-data.sql >> db.sql

# Append dictionaries SQL
echo "" >> db.sql
if [ -f dict.sql ]; then
    cat dict.sql >> db.sql
fi

# Insert a user record same as the boss key to allow seeing your own list of uploaded nets
echo "" >> db.sql
echo "INSERT INTO users (userkey, mail, ip) VALUES (X'$BOSS_KEY', '${MAIL_FROM:-root@localhost}', 0);" >> db.sql

echo "Done"