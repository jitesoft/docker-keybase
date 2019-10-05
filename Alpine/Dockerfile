# syntax = docker/dockerfile:experimental
ARG BUILDPLATFORM
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/go:latest AS stage0
ARG TARGETARCH
ARG VERSION="v4.5.0"
ENV GO15VENDOREXPERIMENT=1 \
    CGO_ENABLED=1 \
    GOARCH="${TARGETARCH}"

RUN apk add --no-cache --virtual .build-deps tar curl grep gcc libstdc++ build-base binutils-gold xz \
 && mkdir -p ${GOPATH}/src/github.com/keybase/client \
 && curl -L https://github.com/keybase/client/releases/download/${VERSION}/keybase-${VERSION}.tar.xz -o /tmp/keybase.tar.xz \
 && tar -Jxf /tmp/keybase.tar.xz -C "${GOPATH}/src/github.com/keybase/client" --strip-components=1 \
 && go build -v -a -tags production github.com/keybase/client/go/keybase \
 && mv ./keybase /usr/local/bin/keybase

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

COPY --from=stage0 /usr/local/bin /usr/local/bin/
COPY ./entrypoint /usr/local/bin/

RUN addgroup -g 1000 keybase \
 && adduser -u 1000 -G keybase -s /bin/sh -D keybase \
 && chmod +x /usr/local/bin

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keybase", "oneshot"]
