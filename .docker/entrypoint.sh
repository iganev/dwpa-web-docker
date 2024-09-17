#!/bin/sh

# Make sure dict and cap are properly setup
chown -R www-data:www-data /srv/app/dict
chmod -R 0644 /srv/app/dict
chown -R www-data:www-data /srv/app/cap
chmod -R 0644 /srv/app/cap

# Dump environment variables for later use by cron jobs
env >> /etc/environment

# Start cron
crond -L /proc/1/fd/1

# Run the php fpm process in the foreground, tying up this so docker doesnt ruturn.
docker-php-entrypoint php-fpm
