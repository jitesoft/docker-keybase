# syntax = docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/keybase/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.app.keybase.version="${VERSION}"

ARG TARGETARCH
RUN --mount=type=bind,source=./binaries,target=/tmp/bin \
    tar -xzhf /tmp/bin/keybase-${TARGETARCH}.tar.gz -C /usr/local/bin \
 && addgroup -g 1000 keybase \
 && adduser -u 1000 -G keybase -s /bin/sh -D keybase \
 && chmod -R +x /usr/local/bin

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keybase", "oneshot"]
