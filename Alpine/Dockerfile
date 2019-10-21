# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/go:latest AS stage0
ARG TARGETARCH
ARG VERSION
ENV GO15VENDOREXPERIMENT=1 \
    CGO_ENABLED=1 \
    GOARCH="${TARGETARCH}"

RUN apk add --no-cache --virtual .build-deps tar curl gcc libstdc++ build-base binutils-gold xz \
 && mkdir -p ${GOPATH}/src/github.com/keybase/client \
 && curl -L https://github.com/keybase/client/releases/download/${VERSION}/keybase-${VERSION}.tar.xz -o /tmp/keybase.tar.xz \
 && tar -Jxf /tmp/keybase.tar.xz -C "${GOPATH}/src/github.com/keybase/client" --strip-components=1 \
 && if [ "${GOARCH}" == "arm64" ]; then \
        curl -L https://musl.cc/aarch64-linux-musl-cross.tgz -o /tmp/compiler.tar.gz; \
        tar -xzf /tmp/compiler.tar.gz -C /usr --strip-components=2; \
        export CC="/usr/bin/aarch64-linux-musl-gcc"; \
        echo "Building for AARCH64."; \
    fi \
 && cd bin \
 && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/keybase \
 && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/kbfs/redirector \
# && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/kbnm \
# && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/kbfs/kbfsfuse \
# && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase \
 && mv * /usr/local/bin \
 && apk del .build-deps

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

COPY --from=stage0 /usr/local/bin /usr/local/bin
COPY ./entrypoint /usr/bin/entrypoint

RUN addgroup -g 1000 keybase \
 && adduser -u 1000 -G keybase -s /bin/sh -D keybase \
 && chmod -R +x /usr/local/bin \
 && chmod +x /usr/bin/entrypoint \
 && keybase --version

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keybase", "oneshot"]
