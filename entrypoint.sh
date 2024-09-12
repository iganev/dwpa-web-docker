crond

# Crons need the current env variables
printenv | sed 's/^\(.*\)$/export "\1"/g' > /srv/app/project_env.sh
chown www-data:www-data /srv/app/project_env.sh
chmod +x /srv/app/project_env.sh

# Run the php fpm process in the foreground, tying up this so docker doesnt ruturn.
docker-php-entrypoint php-fpm
