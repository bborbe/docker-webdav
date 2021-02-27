#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

ulimit -n 8192

if [ "$1" = "/usr/sbin/apache2" ]; then
  echo "configure ..."

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

  PORT=${PORT:-"80"}
  echo "set port to ${PORT}"
  sed -i "s/:80/:${PORT}/" /etc/apache2/sites-enabled/webdav.conf
  sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf

  echo "configure done"
fi

echo "start $@"
exec "$@"
