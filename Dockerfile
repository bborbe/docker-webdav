FROM ubuntu:14.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
	&& apt-get update --quiet \
	&& apt-get upgrade --quiet --yes \
	&& apt-get install --quiet --yes --no-install-recommends apache2 apache2-utils \
	&& apt-get autoremove --yes \
	&& apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN set -x \
	&& a2enmod dav dav_fs \
	&& a2dissite 000-default \
	&& mkdir -p /var/lock/apache2 \
	&& chown www-data /var/lock/apache2 \
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
	&& ln -sf /dev/stderr /var/log/apache2/error.log \
	&& ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log

EXPOSE 80

VOLUME ["/data/webdav"]

ADD webdav.conf /etc/apache2/sites-enabled/

ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/apache2","-D","FOREGROUND"]
