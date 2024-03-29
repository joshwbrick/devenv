FROM ubuntu:22.04 AS devinstall


ARG TZ
ARG DEVENV_LOCALE
ARG DEVENV_USER
ARG DEVENV_PASS
ARG DEVENV_EMAIL
ARG DEVENV_MOUNT_PATH
ARG DEVENV_GIT_DEF_BRANCH
ARG DEVENV_GH_USER
ARG DEVENV_GH_PASS
ARG DEVENV_SH_USER
ARG DEVENV_SH_PASS

ENV TZ=$DEVENV_TZ
ENV DEVENV_LOCALE=$DEVENV_LOCALE
ENV DEVENV_USER=$DEVENV_USER
ENV DEVENV_PASS=$DEVENV_PASS
ENV DEVENV_EMAIL=$DEVENV_EMAIL
ENV DEVENV_MOUNT_PATH=$DEVENV_MOUNT_PATH
ENV DEVENV_GIT_DEF_BRANCH=$DEVENV_GIT_DEF_BRANCH
ENV DEVENV_GH_USER=$DEVENV_GH_USER
ENV DEVENV_GH_PASS=$DEVENV_GH_PASS
ENV DEVENV_SH_USER=$DEVENV_SH_USER
ENV DEVENV_SH_PASS=$DEVENV_SH_PASS

ENV LANG=$DEVENV_LOCALE
ENV NVIM_LISTEN_ADDRESS=/home/${DEVENV_USER}/nvimsocket
ENV DEBIAN_FRONTEND=noninteractive

COPY base/build-install.sh /build-install.sh
RUN /build-install.sh

FROM devinstall AS devbase
COPY base/build-root.sh /build-root.sh
RUN /build-root.sh

FROM devbase AS devinit
USER ${DEVENV_USER}
WORKDIR /home/${DEVENV_USER}
RUN sudo chown -R ${DEVENV_USER}:${DEVENV_USER} /home/${DEVENV_USER}
COPY base/build-init-user.sh /home/${DEVENV_USER}/build-init-user.sh
RUN ./build-init-user.sh

FROM devinit AS devenv
USER ${DEVENV_USER}
WORKDIR /home/${DEVENV_USER}
COPY dotfiles/setup.sh /home/${DEVENV_USER}/setup.sh
COPY base/build-home.sh /home/${DEVENV_USER}/build-home.sh
RUN /home/${DEVENV_USER}/build-home.sh

COPY base/init.vim /home/${DEVENV_USER}/.config/nvim/init.vim
COPY dotfiles/init.vim /home/${DEVENV_USER}/dotfiles/init.vim
COPY base/zshrc /home/${DEVENV_USER}/.zshrc
COPY dotfiles/zshrc /home/${DEVENV_USER}/dotfiles/zshrc
COPY base/start.sh /home/${DEVENV_USER}/start.sh
COPY base/open.sh /home/${DEVENV_USER}/open.sh
RUN sh -c "$(curl -fLsS https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN rm ~/.zshrc
RUN mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
RUN nvim --headless +PlugInstall +qall
VOLUME /home/${DEVENV_USER}/host
ENTRYPOINT ["./start.sh"]

