ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BACKEND_REPO=https://github.com/dogtreatfairy/balboa_worldwide_app.git
ARG BACKEND_REF=99c1eb827f08a301420040632d4d2c36178325db

# Update and install necessary packages in a single RUN to reduce image layers
RUN apk update && apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    ruby \
    ruby-dev \
    ruby-bundler \
    libffi-dev \
    zlib-dev \
    socat \
    tzdata \
    build-base \
  && git clone ${BACKEND_REPO} /tmp/balboa_worldwide_app \
  && cd /tmp/balboa_worldwide_app \
  && git checkout ${BACKEND_REF} \
  && gem build balboa_worldwide_app.gemspec \
  && gem install ./balboa_worldwide_app-*.gem \
  && rm -rf /tmp/balboa_worldwide_app \
  && apk del build-base \
  && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]