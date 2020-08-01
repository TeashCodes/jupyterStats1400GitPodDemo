FROM: jupyter/datascience-notebook:r-3.6.3

LABEL maintainer="UWA Stats1400"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-get install rclone
    pip3 install flask

WORKDIR $HOME