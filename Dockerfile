FROM java:7-jre # TODO Java 8?
MAINTAINER Jens Erat <email@jenserat.de>

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f`; do chmod a-s $i; done

# Fetch and setup BaseX
# TODO fixed version (cache buster), verify hash sum,
# fetch using curl/wget (so we can drop zip file before
# persisted in layers), Version/Hash as environment variable
ADD http://files.basex.org/releases/BaseX-latest.zip /opt/
RUN \
	unzip /opt/BaseX*.zip -d /opt && \
	rm -r /opt/BaseX*.zip /opt/basex/.basexhome /opt/basex/bin/*.bat /opt/basex/etc/factbook.xml /opt/basex/webapp && \
	adduser --system --home /srv --disabled-password --disabled-login --uid 1984 basex && \
	mkdir /srv/BaseXData /srv/BaseXRepo /srv/BaseXWeb && \
	chown basex /srv /srv/*

USER basex
# 1984/tcp: API
# 1985/tcp: Event
# 8984/tcp: HTTP
# 8985/tcp: HTTP stop
EXPOSE 1984 1985 8984 8985
VOLUME ["/srv/BaseXData"]

WORKDIR /opt/basex
CMD ["/opt/basex/bin/basexhttp", "-d", "-z"]
