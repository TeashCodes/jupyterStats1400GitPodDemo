FROM jupyter/r-notebook:acb539921413

LABEL maintainer="UWA Stats1400"

ARG NB_USER="gitpod"
ARG NB_UID="3333"


USER root


### Gitpod user ###
RUN usermod $NB_USER -G sudo && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
ENV HOME=/home/$GITPOD_USERNAME
WORKDIR $HOME
# custom Bash prompt
RUN { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc


### Gitpod user (2) ###
USER $NB_USER
# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir /home/$GITPOD_USERNAME/.bashrc.d && \
    (echo; echo "for i in \$(ls \$HOME/.bashrc.d/*); do source \$i; done"; echo) >> /home/$GITPOD_USERNAME/.bashrc