# Inspired by https://github.com/mumoshu/dcind
FROM alpine as base

LABEL maintainer="Anian Ziegler" \
      email="it@cioplenu.de"

ENV DOCKER_VERSION=19.03.8 \
    DOCKER_COMPOSE_VERSION=1.25.4

# Install Docker and Docker Compose
RUN apk --no-cache add	\
      bash				\
      curl				\
      util-linux		\
      device-mapper		\
      py-pip			\
      python-dev		\
      libffi-dev		\
      openssl-dev		\
      gcc				\
      libc-dev			\
      make				\
      iptables			\
	  jq				\
      go				\
      git			 && \
    curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx		&& \
    mv /docker/* /bin/																						&& \
    chmod +x /bin/docker*																					&& \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION}													&& \
    curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /wait-for-it.sh	&& \
    chmod +x /wait-for-it.sh																				&& \
    rm -rf /root/.cache

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh
COPY setup /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

