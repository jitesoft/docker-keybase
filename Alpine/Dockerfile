FROM registry.gitlab.com/jitesoft/dockerfiles/go:latest AS stage0
ENV GO15VENDOREXPERIMENT=1 \
    CGO_ENABLED=1

COPY ./entrypoint /usr/local/bin/

RUN apk add --no-cache --virtual .build-deps tar curl grep gcc libstdc++ build-base binutils-gold \
 && cd ${GOPATH} \
 && go get github.com/keybase/client/go/keybase \
 && chmod -R +x /usr/local/bin \
 && go install -v -a -tags production github.com/keybase/client/go/keybase \
 && mv ${GOPATH}/bin/keybase /usr/local/bin/keybase

FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ARG KB_HASH
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/keybase/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.app.keybase.hash="${KB_HASH}"



COPY --from=stage0 /usr/local/bin /usr/local/bin/

RUN addgroup -g 1000 keybase \
 && adduser -u 1000 -G keybase -s /bin/sh -D keybase \
 && chmod +x /usr/local/bin

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keybase", "oneshot"]
