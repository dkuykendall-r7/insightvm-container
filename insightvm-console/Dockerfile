FROM ubuntu:latest as insightvm-starter
RUN apt-get update && apt-get -y install tmux curl expect screen && apt-get clean
WORKDIR /tmp
ADD https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin /tmp/Rapid7Setup-Linux64.bin
RUN chmod +x /tmp/Rapid7Setup-Linux64.bin
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM insightvm-starter AS insightvm-console-installed
WORKDIR /tmp

# Run the installer
RUN /tmp/Rapid7Setup-Linux64.bin -q -dir /opt/rapid7/nexpose -Dinstall4j.suppressUnattendedReboot=true -Vfirstname="InsightVM Console" -Vlastname="Docker Container" -Vcompany=Rapid7 -Vusername=ivmadmin -Vpassword1=ivmadmin -Vpassword2=ivmadmin
# Disable traditional updates:
RUN echo "com.rapid7.updater.disabled=1" > /opt/rapid7/nexpose/nse/CustomEnvironment.properties
# Tag to check if Scan Engine is running in container:
RUN echo "com.rapid7.nexpose.nse.container=true" > /opt/rapid7/nexpose/nse/CustomEnvironment.properties
# Cleanup installer files
RUN rm /tmp/Rapid7Setup-Linux64.bin

# Move all the default persistent data files into our default_data folder until we launch for real
RUN mkdir /opt/rapid7/default_data
RUN mkdir /opt/rapid7/default_data/nse-keystores
RUN mv /opt/rapid7/nexpose/nse/conf            /opt/rapid7/default_data/nse-conf

RUN mv /opt/rapid7/nexpose/nsc/conf            /opt/rapid7/default_data/nsc-conf
RUN mv /opt/rapid7/nexpose/nsc/keystores       /opt/rapid7/default_data/nsc-keystores
RUN mv /opt/rapid7/nexpose/nsc/logs            /opt/rapid7/default_data/nsc-logs
RUN mv /opt/rapid7/nexpose/nsc/htroot/reports  /opt/rapid7/default_data/nsc-reports

RUN mv /opt/rapid7/nexpose/nsc/nxpgsql         /opt/rapid7/default_data/nsc-nxpgsql
#RUN mv /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata /opt/rapid7/default_data/nsc-nxpdata
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM postgres:latest
RUN apt-get update && apt-get clean
COPY --from=insightvm-console-installed /opt/rapid7/ /opt/rapid7/
VOLUME [ "/opt/rapid7/persistent_data", "/opt/rapid7/nexpose/nsc/nxpgsql"]
EXPOSE 3780/tcp
WORKDIR /opt
COPY init_container.sh /opt
RUN chmod +x /opt/init_container.sh
ENTRYPOINT ["./init_container.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]