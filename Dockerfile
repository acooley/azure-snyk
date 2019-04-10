FROM snyk/snyk-cli:npm as snyk-cli
FROM ubuntu:latest as base

MAINTAINER Kunai

# Install Node.js
RUN apt-get update
RUN apt-get install --yes curl
#RUN curl --silent --location https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install --yes nodejs npm
RUN apt-get install --yes build-essential

# Install Docker
RUN apt-get update
RUN apt-get install --yes docker.io

# Install snyk cli
RUN npm install --global snyk snyk-to-html && \
    apt-get update && \
    apt-get install -y jq

RUN mkdir /home/node
RUN chmod -R a+wrx /home/node
WORKDIR /home/node
ENV HOME /home/node

# The path at which the project is mounted (-v runtime arg)
ENV PROJECT_PATH /project

COPY --from=snyk-cli /home/node/docker-entrypoint.sh .
COPY --from=snyk-cli /home/node/snyk_report.css .
