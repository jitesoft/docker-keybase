FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:latest as Build
WORKDIR /home/root
RUN apt-get -qq update \
 && apt-get -qq install -y curl \
 && curl -OsS https://prerelease.keybase.io/keybase_amd64.deb \
 && dpkg -i keybase_amd64.deb || true \
 && rm keybase_amd64.deb \
 && apt-get install -fy \
 && apt-get purge -y curl \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -s /bin/bash -m keybase

USER keybase

CMD ["keybase", "--help"]
