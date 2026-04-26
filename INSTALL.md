# INSTALLATION

## Docker

### phpmyadmin

* Ensure that `post_max_size` is high enough - for uploading SQL files.

## Setup$$

### Edit Settings

`Settings.php`

```php
$boardurl = 'https://localhost:8443';
$webmaster_email = 'no-reply@teufelskueche-bn.de';
$db_server = 'mysql';
$db_name = 'smf';
$db_user = 'user';
$db_passwd = 'pass';
$cachedir = '/app/cache';
$boarddir = '/app';
$sourcedir = '/app/Sources';
$packagesdir = '/app/Packages';
$tasksdir = '/app/Sources/tasks';
$cachedir = '/app/cache';
$cachedir_sqlite = '/app/cache';
```

* $db_server
* $db_name
* $db_user
* $db_passwd
* $boardurl
* $webmaster_email
* various directory strings

### Copy Files

```bash
docker-compose exec smf bash -c "rm -rf /app/*"

docker-compose exec smf bash -c "ls -als /app"

docker-compose cp ../Backups/2024-06-17\ Forum\ Backup/slyboard/. smf:/app

docker-compose exec smf bash -c "cd /app && chown -R www-data:www-data *"

docker-compose exec smf bash -c "ls -als /app"
```

### Database

```bash
docker exec -i test_mysql sh -c 'exec mysql "smf" -u"user" -p"pass"' < ../Backups/2024-06-17\ Forum\ Backup/phpMyAdmin\ Backup/DB3405906.sql
```

Export:

File: .my.cnf

```cnf
[mysqldump]
user=user
password=pass
```

```bash
docker-compose cp .my.cnf mysql:/root

docker-compose exec mysql bash

chown root:root /root/.my.cnf && chmod 0600 /root/.my.cnf

mysqldump smf --no-tablespaces > backup.sql
```

### SMF Updates

* 2.1.3 Update: https://custom.simplemachines.org/mods/downloads/smf_2-1-3_patch.tar.gz
* 2.1.4 Update: https://custom.simplemachines.org/mods/downloads/smf_2-1-4_patch.tar.gz

Copied into backups/slyboard/Packages

```bash
dco cp ../Backups/smf_2-1-3_patch.tar.gz smf:/app/Packages
dco cp ../Backups/smf_2-1-4_patch.tar.gz smf:/app/Packages
```
