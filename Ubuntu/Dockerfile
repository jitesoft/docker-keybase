# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu:latest AS stage0
ARG TARGETARCH
ARG VERSION
ENV CGO_ENABLED=1 \
    GOARCH="${TARGETARCH}"

RUN apt-get update \
 && apt-get install -y curl tar xz-utils gcc \
 && mkdir -p "${GOPATH}/src/github.com/keybase/client" \
 && curl -L https://github.com/keybase/client/releases/download/${VERSION}/keybase-${VERSION}.tar.xz -o /tmp/keybase.tar.xz \
 && tar -Jxf /tmp/keybase.tar.xz -C "${GOPATH}/src/github.com/keybase/client" --strip-components=1 \
 && if [ "${GOARCH}" = "arm64" ]; then \
        apt-get install -y gcc-aarch64-linux-gnu; \
        export CC="/usr/bin/aarch64-linux-gnu-gcc"; \
        echo "Building for AARCH64"; \
    fi \
 && cd bin \
 && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/keybase \
 && go build -v -a -ldflags "-linkmode external -extldflags '-static' -s -w" -buildmode=pie -tags production github.com/keybase/client/go/kbfs/redirector \
 && mv * /usr/local/bin

FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
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

RUN  useradd -u 1000 -s /bin/bash -m keybase \
 && chmod +x /usr/bin/entrypoint \
 && chmod -R +x /usr/local/bin \
 && keybase --version

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keyubase", "oneshot"]
