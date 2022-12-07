FROM postgres:latest

#RUN /bin/sh -c mkdir -p /run/systemd && echo 'docker' > /run/systemd/container

RUN apt-get update && apt-get -y install tmux wget

WORKDIR /opt
#CMD ["/bin/sh" "-c" "tmux new -s docker_mux"]
ENTRYPOINT ["tail", "-f", "/dev/null"]
