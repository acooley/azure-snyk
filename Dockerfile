FROM snyk/snyk-cli:npm as snyk-cli
FROM node:8 as base

MAINTAINER Kunai

# Install Docker
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install -y docker-ce

# Install snyk cli
RUN npm install --global snyk snyk-to-html && \
    apt-get update && \
    apt-get install -y jq

RUN chmod -R a+wrx /home/node
WORKDIR /home/node
ENV HOME /home/node

# The path at which the project is mounted (-v runtime arg)
ENV PROJECT_PATH /project

COPY --from=snyk-cli /home/node/docker-entrypoint.sh .
COPY --from=snyk-cli /home/node/snyk_report.css .

ENTRYPOINT ["./docker-entrypoint.sh"]

# Default command is `snyk test`
# Override with `docker run ... snyk/snyk-cli <command> <args>`
CMD ["test"]