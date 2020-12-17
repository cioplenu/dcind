# Inspired by https://github.com/mumoshu/dcind
FROM alpine as base

LABEL maintainer="Anian Ziegler" \
      email="it@cioplenu.de"

# Install Docker and Docker Compose
RUN apk --no-cache add	\
		bash			\
		curl			\
		docker			\
		docker-compose	\
		jq			 && \
    curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /wait-for-it.sh	&& \
    chmod +x /wait-for-it.sh																				&& \
    rm -rf /root/.cache

# Include functions to start/stop docker daemon
COPY docker-lib.sh /docker-lib.sh
COPY entrypoint.sh /entrypoint.sh
COPY setup /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

