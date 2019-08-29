FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/keybase/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/keybase"

ARG VERSION="4.3.2"
ARG BUILD_DEPS="gnupg curl grep"
ARG FINGERPRINT="222B85B0F90BE2D24CFEB93F47484E50656D16C7"

COPY ./entrypoint /usr/bin/

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends $BUILD_DEPS \
 && gpg --keyserver pgp.mit.edu --recv-keys "${FINGERPRINT}" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "${FINGERPRINT}" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${FINGERPRINT}" \
 && curl -OsS https://prerelease.keybase.io/keybase_amd64.deb \
 && curl -OsS https://prerelease.keybase.io/keybase_amd64.deb.sig \
 && gpg --verify keybase_amd64.deb.sig keybase_amd64.deb \
 && dpkg -i keybase_amd64.deb || true \
 && rm keybase_amd64.* \
 && apt-get install --no-install-recommends -fy \
 && apt-get purge -y $BUILD_DEPS \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -s /bin/bash -m keybase \
 && chmod +x /usr/bin/entrypoint

USER keybase

ENTRYPOINT ["entrypoint"]
CMD ["keybase", "--help"]
