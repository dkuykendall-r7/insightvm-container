FROM ubuntu:latest as insightvm-starter
RUN apt-get update && apt-get -y install tmux curl expect screen && apt-get clean
WORKDIR /tmp
ADD https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin /tmp/Rapid7Setup-Linux64.bin
RUN chmod +x /tmp/Rapid7Setup-Linux64.bin
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM insightvm-starter AS insightvm-scanengine-installed
WORKDIR /tmp
COPY response.varfile /tmp
# Run the installer
RUN /tmp/Rapid7Setup-Linux64.bin -q -varfile /tmp/response.varfile
# Disable traditional updates:
RUN echo "com.rapid7.updater.disabled=1" > /opt/rapid7/nexpose/nse/CustomEnvironment.properties
# Tag to check if Scan Engine is running in container:
RUN echo "com.rapid7.nexpose.nse.container=true" > /opt/rapid7/nexpose/nse/CustomEnvironment.properties
# Cleanup installer files
RUN rm /tmp/Rapid7Setup-Linux64.bin /tmp/response.varfile

# Move all the default persistent data files into our default_data folder until we launch for real
RUN mkdir /opt/rapid7/default_data
RUN mkdir /opt/rapid7/default_data/nse-keystores
RUN mv /opt/rapid7/nexpose/nse/conf            /opt/rapid7/default_data/nse-conf








ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM ubuntu:latest
RUN apt-get update && apt-get clean
COPY --from=insightvm-scanengine-installed /opt/rapid7/ /opt/rapid7/
VOLUME [ "/opt/rapid7/persistent_data"]
EXPOSE 40814/tcp
WORKDIR /opt
COPY init_container.sh /opt
RUN chmod +x /opt/init_container.sh
ENTRYPOINT ["./init_container.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]