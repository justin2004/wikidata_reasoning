FROM debian:10
RUN apt-get update && apt-get install -y  default-jre-headless wget
RUN apt-get install -y vim-tiny entr make


# TODO note the image on dockerhub will only be agreeable if your uid and gid are:
#   if not you need to build this image yourself (see README.md)
ARG uid=1000
ARG gid=1000
ARG user=containeruser

RUN groupadd -g $gid $user || true
RUN useradd $user --uid $uid --gid $gid --home-dir /home/$user && \
    mkdir /home/$user && \
    chown $uid:$gid /home/$user

RUN cp /root/.bashrc /home/containeruser/.bashrc && chown $user:$user /home/containeruser/.bashrc

USER $user
WORKDIR /home/$user

RUN wget 'https://apache.osuosl.org/jena/binaries/apache-jena-3.17.0.tar.gz' && tar -xaf apache-jena-3.17.0.tar.gz

RUN echo 'declare -x PATH=$PATH:/home/containeruser/apache-jena-3.17.0/bin/' >> /home/containeruser/.bashrc
WORKDIR /mnt

CMD bash -c 'source ~/.bashrc && make live'
