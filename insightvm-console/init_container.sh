#!/bin/bash
DATADIR="/opt/rapid7/persistent_data"
echo "CONTAINER NOTICE: Checking if this is a first time launch"
if [ "$(ls -A $DATADIR)" ]; then
    echo "CONTAINER NOTICE: Data in place, continue launching..."
    adduser --uid 1000 --gecos "NeXpose PostgreSQL User" --home /opt/rapid7/nexpose/nsc/nxpgsql --no-create-home --disabled-password nxpgsql
else
    echo "CONTAINER NOTICE: Looks like the first run, will move default data files into place."
    mv /opt/rapid7/default_data/nsc-nxpgsql/* /opt/rapid7/nexpose/nsc/nxpgsql/
    rmdir /opt/rapid7/default_data/nsc-nxpgsql
    mv /opt/rapid7/default_data/* /opt/rapid7/persistent_data/
    echo "CONTAINER NOTICE: Data is now in place, continue launching..."
fi
echo "CONTAINER NOTICE: Cleaning up default data"
rm -rf /opt/rapid7/default_data/

echo "CONTAINER NOTICE: Link persistent data paths"
cd /opt/rapid7
ln -s /opt/rapid7/persistent_data/nse-conf      /opt/rapid7/nexpose/nse/conf
ln -s /opt/rapid7/persistent_data/nse-keystores /opt/rapid7/nexpose/nse/keystores

ln -s /opt/rapid7/persistent_data/nsc-conf      /opt/rapid7/nexpose/nsc/conf
ln -s /opt/rapid7/persistent_data/nsc-keystores /opt/rapid7/nexpose/nsc/keystores
ln -s /opt/rapid7/persistent_data/nsc-logs      /opt/rapid7/nexpose/nsc/logs
ln -s /opt/rapid7/persistent_data/nsc-reports   /opt/rapid7/nexpose/nsc/htroot/reports
#ln -s /opt/rapid7/persistent_data/nsc-nxpdata   /opt/rapid7/nexpose/nsc/nxpgsql/nxpdata
echo "CONTAINER NOTICE: Ready to launch Nexpose Console (./nsc.sh)"
cd /opt/rapid7/nexpose/nsc
./nsc.sh
tail -f /dev/null
