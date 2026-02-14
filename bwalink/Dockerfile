ARG BUILD_FROM
FROM ${BUILD_FROM}

# Update and install necessary packages in a single RUN to reduce image layers
RUN apk update && apk add --no-cache \
    bash \
    curl \
    ruby \
    ruby-dev \
    ruby-bundler \
    libffi-dev \
    zlib-dev \
    socat \
    tzdata \
    build-base \
  && bundle config set deployment 'true' \
  && gem install mqtt-homie-homeassistant -v '~> 1.1.0' \
  && gem install balboa_worldwide_app \
  && apk del build-base \
  && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]