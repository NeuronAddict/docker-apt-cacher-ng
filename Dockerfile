FROM debian:buster-slim

RUN apt-get update && apt-get -y install apt-cacher-ng strace && apt-get autoclean && apt-get autoremove

COPY za_docker.conf /etc/apt-cacher-ng/

EXPOSE 3142

RUN mkdir -p /acng/acng && cp -a /var/cache/apt-cacher-ng /acng/acng/apt-cacher-ng && chown apt-cacher-ng:apt-cacher-ng /acng/acng /var/log/apt-cacher-ng && ls -al /acng/acng/*

VOLUME ["/acng"]

USER apt-cacher-ng

CMD /usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng && tail -f /var/log/apt-cacher-ng/*
