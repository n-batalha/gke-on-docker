FROM google/cloud-sdk:latest

RUN apt-get update && apt-get install -y -qq --no-install-recommends \
    make \
    docker
