FROM node:12-alpine

RUN addgroup -g 501 -S jenkins && adduser -S -G jenkins -u 501 -s /bin/bash -h /home/jenkins jenkins \
    && mkdir -p /home/jenkins && chown -R jenkins:jenkins /home/jenkins \
    && chown -R jenkins:jenkins /usr/local/ && chmod -R a+w /usr/local/

WORKDIR /home/jenkins

RUN apk update && apk --no-cache upgrade

# RUN apk add --no-cache --virtual .build-deps

RUN apk --no-cache --update add jq bash curl musl-dev gcc python3 python3-dev

RUN python3 -m ensurepip --upgrade \
    && pip3 install --upgrade pip

# RUN pip3 install --upgrade virtualenv awscli aws-sam-cli
RUN pip3 install awscli aws-sam-cli

RUN pip3 uninstall --yes pip \
    && apk del python3-dev gcc musl-dev

RUN rm /var/cache/apk/*

USER jenkins

RUN npm install -g mocha