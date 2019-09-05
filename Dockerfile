# Inspired by https://github.com/mumoshu/dcind
FROM alpine:3.10 as base

LABEL maintainer="Anian Ziegler" \
      email="it@cioplenu.de"

ENV DOCKER_VERSION=18.09.8 \
    DOCKER_COMPOSE_VERSION=1.24.1

# Install Docker and Docker Compose
RUN apk --no-cache add bash curl util-linux device-mapper py-pip python-dev libffi-dev openssl-dev gcc libc-dev make iptables && \
    curl https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar zx && \
    mv /docker/* /bin/ && \
    chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    rm -rf /root/.cache

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh
COPY setup /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

FROM base as go

RUN apk --no-cache add go git

