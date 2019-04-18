FROM snyk/snyk-cli:npm as snyk-cli
FROM ubuntu:latest as base

MAINTAINER Kunai

RUN apt-get update

# Install Node.js
RUN apt-get install --yes curl
RUN apt-get install --yes nodejs npm
RUN apt-get install --yes build-essential

# Install Docker
RUN apt-get install --yes docker.io

# Install snyk cli
RUN npm install --global snyk snyk-to-html && \
    apt-get install -y jq

# Install Maven
RUN apt-get install --yes maven

# Install Python
RUN apt-get install --yes python3
RUN apt-get install --yes python3-pip


RUN mkdir /home/node
RUN chmod -R a+wrx /home/node
WORKDIR /home/node
ENV HOME /home/node

# The path at which the project is mounted (-v runtime arg)
ENV PROJECT_PATH /project

COPY --from=snyk-cli /home/node/docker-entrypoint.sh .
COPY --from=snyk-cli /home/node/snyk_report.css .
