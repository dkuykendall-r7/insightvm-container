#!/bin/bash

CONFDIR="/opt/rapid7/nexpose/nsc/conf"
echo "CONTAINER NOTICE: Checking if this is a first time launch"
if [ "$(ls -A $CONFDIR)" ]; then
    echo "CONTAINER NOTICE: Data in place, start Nexpose Console"
    adduser --uid 1000 --gecos "NeXpose PostgreSQL User" --shell /bin/sh --home /opt/rapid7/nexpose/nsc/nxpgsql --no-create-home --disabled-password nxpgsql
else
    echo "CONTAINER NOTICE: Looks like the first run, will move default data files into place."
    # The Consoles persistent data volumes
    mv /opt/init_data/plugins/* /opt/rapid7/nexpose/plugins/
    mv /opt/init_data/shared/* /opt/rapid7/nexpose/shared/   
    mv /opt/init_data/nsc_conf/* /opt/rapid7/nexpose/nsc/conf/
    mv /opt/init_data/nsc_reports/* /opt/rapid7/nexpose/nsc/htroot/reports/
    mv /opt/init_data/nsc_keystores/* /opt/rapid7/nexpose/nsc/keystores/
    mv /opt/init_data/nsc_logs/* /opt/rapid7/nexpose/nsc/logs/
    mv /opt/init_data/nsc_nxpgsql/* /opt/rapid7/nexpose/nsc/nxpgsql/
    #mv /opt/init_data/nsc_nxpdata/* /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata/
    mv /opt/init_data/nsc_nse/* /opt/rapid7/nexpose/nse/
    echo "CONTAINER NOTICE: Data is now in place, start Nexpose Console"
fi
echo "CONTAINER NOTICE: Cleaning up default data"
rm -rf /opt/init_data

echo "CONTAINER NOTICE: Ready to launch Nexpose Console (./nsc.sh)"
cd /opt/rapid7/nexpose/nsc
./nsc.sh
#tail -f /dev/null