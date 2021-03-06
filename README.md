# Keybase

[![Docker Pulls](https://img.shields.io/docker/pulls/jitesoft/keybase.svg)](https://hub.docker.com/r/jitesoft/keybase)
[![Back project](https://img.shields.io/badge/Open%20Collective-Tip%20the%20devs!-blue.svg)](https://opencollective.com/jitesoft-open-source)
[![pipeline status](https://gitlab.com/jitesoft/dockerfiles/keybase/badges/master/pipeline.svg)](https://gitlab.com/jitesoft/dockerfiles/keybase/commits/master)

This image contains the [Keybase](https://keybase.io/) application running on ubuntu linux.  

## Tags

Tags follow the keybase version numbering standard (prefixed with `v`) and the latest version is also tagged `latest`.    
Keybase is built from source for amd64 and arm64/aarch64.

To make the image as tiny as possible, [UPX](https://upx.github.io/) have been utilized to compress the binaries used by keybase.  
If you notice any compression issues, please report it in the [issue tracker](https://gitlab.com/jitesoft/dockerfiles/keybase/issues).

### Docker Hub

* `latest`, `v4.5.0`
* `latest-alpine`, `v4.5.0-alpine`

### GitLab

* `registry.gitlab.com/jitesoft/dockerfiles/keybase`
  * `latest`, `v4.5.0`
* `registry.gitlab.com/jitesoft/dockerfiles/keybase/alpine`
  * `latest`, `v4.5.0`

### Quay.io

* `quay.io/jitesoft/keybase`
  * `latest`, `v4.5.0`
  * `latest-alpine`, `v4.5.0-alpine`
  
Dockerfile can be found at [GitLab](https://gitlab.com/jitesoft/dockerfiles/keybase) and [GitHub](https://github.com/jitesoft/docker-keybase).

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

## Licenses

This repository and the files therein are released under the [MIT](https://gitlab.com/jitesoft/dockerfiles/keybase/blob/master/LICENSE) license.  
Keybase is released under the [BSD 3-Clause "New" or "Revised"](https://github.com/keybase/client/blob/master/LICENSE) license.
