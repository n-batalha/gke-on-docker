# Adapted from
#  https://github.com/GoogleCloudPlatform/cloud-sdk-docker/
#  https://hub.docker.com/r/google/cloud-sdk/

FROM docker:latest
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && apk add make \
    unzip \
    php5-mysql \
    php5-cli \
    php5-cgi \
    # Install community one only if needed
    # openjdk-7-jre-headless \
    openssh-client \
    py-openssl \
    bash \
    python \
    python-dev \
    py-pip \
 && apk del --purge deps \
 && rm /var/cache/apk/*

# Install the Google Cloud SDK.
ENV HOME /
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
# app-engine-java
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-python app kubectl alpha beta gcd-emulator pubsub-emulator cloud-datastore-emulator app-engine-go bigtable

# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# Disable updater completely.
# Running `gcloud components update` doesn't really do anything in a union FS.
# Changes are lost on a subsequent run.
RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json

RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
VOLUME ["/.config"]
#CMD ["/bin/bash"]
