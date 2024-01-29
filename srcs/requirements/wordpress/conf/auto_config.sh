#!/bin/sh
wp_config_file="/var/www/wordpress/wp-config.php"

echo "sleep start"
sleep 30
echo "sleep end"

if [ -f "$wp_config_file" ]; then
    echo "erasing wp-config.php"
    rm -rf $wp_config_file
fi

if [ ! -f "$wp_config_file" ]; then
#####		CONFIGURING SQL DATABASE FOR WORDPRESS
    echo "Setting up php"
    # wp --allow-root config create \
    /usr/local/bin/wp-cli.phar --allow-root config create \
        --dbname="$SQL_DATABASE" \
        --dbuser="$SQL_USER" \
        --dbpass="$SQL_PASSWORD" \
        --dbhost="mariadb:3306" --path='/var/www/wordpress'

#####		Creating Page
    echo "Creating page"
    /usr/local/bin/wp-cli.phar --allow-root core install \
        --url='https://localhost' \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path='/var/www/wordpress/'

####	ADDING A USER
    echo "Adding a user"
    /usr/local/bin/wp-cli.phar --allow-root user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --path='/var/www/wordpress/'
    echo "check user creation at localhost/wp-login.php"
fi

echo "Executing php-fpm"
/usr/sbin/php-fpm 7.3 -F 
# /usr/sbin/php-fpm7.3 -F 