#!/usr/bin/env bash

BACKUP="../Backups/test"

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
