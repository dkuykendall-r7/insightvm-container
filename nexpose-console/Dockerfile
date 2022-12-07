FROM ubuntu:latest

RUN apt-get update && apt-get -y install tmux wget expect screen libxml2
RUN apt-get install -y --no-install-recommends curl unzip
RUN apt-get clean

WORKDIR /opt
RUN wget -O /opt/Rapid7Setup-Linux64.bin https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin
RUN chmod +x /opt/Rapid7Setup-Linux64.bin

COPY install_script.exp /opt/install_script.exp
RUN chmod +x /opt/install_script.exp
COPY init_container.sh /opt/init_container.sh
RUN chmod +x /opt/init_container.sh
RUN /opt/install_script.exp John Doe Rapid7 testuser testp@ss

RUN rm /opt/install_script.exp
RUN rm /opt/Rapid7Setup-Linux64.bin

# Move all the data files into our init_data folder until we launch for real
RUN mkdir /opt/init_data

# The Consoles persistent data volumes
RUN mv /opt/rapid7/nexpose/plugins /opt/init_data/plugins
RUN mv /opt/rapid7/nexpose/shared /opt/init_data/shared
RUN mv /opt/rapid7/nexpose/nsc/conf /opt/init_data/nsc_conf
RUN mv /opt/rapid7/nexpose/nsc/keystores /opt/init_data/nsc_keystores
RUN mv /opt/rapid7/nexpose/nsc/logs /opt/init_data/nsc_logs
RUN mv /opt/rapid7/nexpose/nsc/htroot/reports /opt/init_data/nsc_reports
RUN mv /opt/rapid7/nexpose/nsc/nxpgsql /opt/init_data/nsc_nxpgsql
#RUN mv /opt/rapid7/nexpose/nsc//nxpgsql/nxpdata /opt/init_data/nsc_nxpdata
RUN mv /opt/rapid7/nexpose/nse /opt/init_data/nsc_nse

EXPOSE 3780/tcp
WORKDIR /opt
ENTRYPOINT ["./init_container.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
