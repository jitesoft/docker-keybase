FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/keybase" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/keybase/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/keybase"

COPY ./keybase_amd64.deb /tmp/keybase_amd64.deb
COPY ./entrypoint /usr/bin/

RUN cd /tmp \
 && dpkg -i keybase_amd64.deb || true \
 && rm keybase_amd64.deb \
 && apt-get install --no-install-recommends -fy \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -s /bin/bash -m keybase \
 && chmod +x /usr/bin/entrypoint

USER keybase

ENTRYPOINT ["entrypoint"]
CMD ["keybase", "--help"]
