FROM registry.gitlab.com/jitesoft/dockerfiles/go:latest AS stage0

ARG VERSION="4.3.2"
ARG FINGERPRINT="222B85B0F90BE2D24CFEB93F47484E50656D16C7"

COPY ./entrypoint /usr/local/bin/

ENV GO15VENDOREXPERIMENT=1 \
    CGO_ENABLED=1

RUN apk add --no-cache --virtual .build-deps tar curl grep gcc libstdc++ build-base binutils-gold \
 && cd ${GOPATH} \
 && go get github.com/keybase/client/go/keybase \
 && chmod -R +x /usr/local/bin \
 && go install -v -a -tags production github.com/keybase/client/go/keybase \
 && mv ${GOPATH}/bin/keybase /usr/local/bin/keybase

FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
COPY --from=stage0 /usr/local/bin /usr/local/bin/

RUN addgroup -g 1000 keybase \
 && adduser -u 1000 -G keybase -s /bin/sh -D keybase \
 && chmod +x /usr/local/bin

USER keybase
ENTRYPOINT ["entrypoint"]
CMD ["keybase", "oneshot"]
