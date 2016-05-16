#!/bin/bash
set -e

WEBDAV_USERNAME=${WEBDAV_USERNAME:-'webdav'}
WEBDAV_PASSWORD=${WEBDAV_PASSWORD:-'S3CRET'}

echo "setup htpasswd"
htpasswd -cb /etc/apache2/webdav.password ${WEBDAV_USERNAME} ${WEBDAV_PASSWORD}
chown root:www-data /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

echo "set owner for /webdav"
mkdir -p /data/webdav
chown -R www-data:www-data /data/webdav
chmod 750 /data/webdav

echo "starting apache with $@"
exec "$@"