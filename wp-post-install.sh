#! /bin/bash

DOM=$1
if test -z $DOM ; then
    echo "ERROR: no domain informed!"
    exit 1
fi

if [ ! -e "/var/www/${DOM}/wp-config.php" ] ; then
    echo "ERROR: ${DOM} does not appear to be a valid WordPress!"
    exit 1
fi

cd "/var/www/${DOM}/htdocs" || exit 1

### Install plugins from official repository
wp plugin install wordpress-seo --allow-root --activate

### Install custom plugin
wp plugin install https://github.com/wp-sync-db/wp-sync-db/archive/master.zip --allow-root
wp plugin install https://github.com/wp-sync-db/wp-sync-db-media-files/archive/master.zip --allow-root
wp plugin activate wp-sync-db --allow-root
wp plugin activate wp-sync-db-media-files --allow-root

### Fix permissions
chown www-data:www-data wp-content -R
cd -

exit 0