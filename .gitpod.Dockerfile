FROM jupyter/r-notebook:acb539921413

LABEL maintainer="UWA Stats1400"

ARG GITPOD_USERNAME="gitpod"

USER root


# RUN apt-get -yq install software-properties-common
# ### Git ###
# RUN add-apt-repository -y ppa:git-core/ppa \
#     && apt-get install -yq git \
#     && rm -rf /var/lib/apt/lists/*

### Gitpod user ###
# '-l': see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
RUN useradd -l -u 33333 -G sudo -md /home/$GITPOD_USERNAME -s /bin/bash -p $GITPOD_USERNAME $GITPOD_USERNAME \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/$GITPOD_USERNAME
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc


### Move all the stuff setup by jupyter

RUN mv /home/$NB_USER /home/$GITPOD_USERNAME && \
    usermod -l $NB_USER $GITPOD_USERNAME &&\
    groupmod -n $NB_USER $GITPOD_USERNAME

#ENV NB_USER="gitpod"
#ENV NB_UID="1000"
#ENV NB_GID="100"


### Gitpod user (2) ###
USER $GITPOD_USERNAME
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir /home/$GITPOD_USERNAME/.bashrc.d && \
    (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/$GITPOD_USERNAME/.bashrc