FROM jupyter/r-notebook:acb539921413

LABEL maintainer="UWA Stats1400"

USER root

### Gitpod user ###
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod && \
    rm -r /home/gitpod && \
    mv /home/$NB_USER /home/gitpod && \
    usermod $NB_USER -G sudo,gitpod && \
    chown -R gitpod:gitpos && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

ENV HOME=/home/gitpod
WORKDIR $HOME

# custom Bash prompt
USER gitpod
# RUN  { echo && echo "PS1='\[\e]0;\u \w\a\]\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \\\$ '" ; } >> .bashrc

### Gitpod user (2) ###


