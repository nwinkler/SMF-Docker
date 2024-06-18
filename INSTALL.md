# INSTALLATION

## Docker

### phpmyadmin

* Ensure that `post_max_size` is high enough - for uploading SQL files.

## Setup$$

### Edit Settings

`Settings.php`

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
