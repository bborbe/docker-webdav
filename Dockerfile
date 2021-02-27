FROM ubuntu:20.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ARG VERSION

ENV HOME /root
ENV LANG en_US.UTF-8

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive apt-get update --quiet \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade --quiet --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends \
	locales \
	apt-transport-https \
	ca-certificates \
	apache2 \
	apache2-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-get autoremove --yes \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean
RUN locale-gen en_US.UTF-8

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN set -x \
	&& a2enmod dav dav_fs \
	&& a2dissite 000-default \
	&& mkdir -p /var/lock/apache2 /var/run/apache2 \
	&& chown www-data /var/lock/apache2 /var/run/apache2 \
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
	&& ln -sf /dev/stderr /var/log/apache2/error.log \
	&& ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log

COPY files/webdav.conf /etc/apache2/sites-enabled/webdav.conf
COPY files/entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/apache2","-D","FOREGROUND"]
