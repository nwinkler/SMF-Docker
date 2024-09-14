#!/usr/bin/env bash

BACKUP="$1"

if [[ -z "$BACKUP" ]]; then
    echo "Please provide the backup path as a parameter"

    exit 1
fi

echo "Using backup folder: $BACKUP"

echo "Removing /app"
docker-compose exec smf bash -c "rm -rf /app/*"

docker-compose exec smf bash -c "ls -als /app"

echo "Copying over files from $BACKUP"
docker-compose cp "$BACKUP"/slyboard/. smf:/app

docker-compose exec smf bash -c "cd /app && chown -R www-data:www-data *"

docker-compose exec smf bash -c "ls -als /app"

# DATABASE IMPORT
echo "Importing database"

docker exec -i test_mariadb sh -c 'exec mariadb "smf" -u"user" -p"pass"' < "$BACKUP"/backup.sql

echo "Done"
