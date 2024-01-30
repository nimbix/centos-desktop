FROM centos:7
LABEL maintainer="Nimbix, Inc."

WORKDIR /tmp

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER=20240130.1000
ENV SERIAL_NUMBER=${SERIAL_NUMBER}

ARG GIT_BRANCH=master
ENV GIT_BRANCH=${GIT_BRANCH}

# Install image-common for X, VNC and common utilities
RUN yum update -y && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop

COPY NAE/screenshot.png /etc/NAE/screenshot.png
COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://cloud.nimbix.net/api/jarvice/validate
RUN mkdir -p /etc/NAE && touch /etc/NAE/screenshot.png /etc/NAE/screenshot.txt /etc/NAE/license.txt /etc/NAE/AppDef.json
