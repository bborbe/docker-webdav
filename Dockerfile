FROM ubuntu:14.04
MAINTAINER Benjamin Borbe <bborbe@rocketnews.de>
ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN set -x \
	&& apt-get update --quiet \
	&& apt-get upgrade --quiet --yes \
	&& apt-get install --quiet --yes --no-install-recommends apache2 \
	&& apt-get autoremove --yes \
	&& apt-get clean

EXPOSE 80

CMD ["/usr/sbin/named","-u","webdav","-g","-f"]
