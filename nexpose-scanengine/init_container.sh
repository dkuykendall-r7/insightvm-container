#!/bin/bash

CONFDIR="/opt/rapid7/nexpose/nse"
echo "CONTAINER NOTICE: Checking if this is a first time launch"
if [ "$(ls -A $CONFDIR)" ]; then
    echo "CONTAINER NOTICE: Data in place, start Nexpose Console"
else
    echo "CONTAINER NOTICE: Looks like the first run, will move default data files into place."
    # The ScanEngine persistent data volumes
    mv /opt/init_data/plugins/* /opt/rapid7/nexpose/plugins/
    mv /opt/init_data/shared/* /opt/rapid7/nexpose/shared/   
    mv /opt/init_data/nse/* /opt/rapid7/nexpose/nse/






    echo "CONTAINER NOTICE: Data is now in place, start Nexpose Console"
fi
echo "CONTAINER NOTICE: Cleaning up default data"
rm -rf /opt/init_data

echo "CONTAINER NOTICE: Ready to launch Nexpose Console (./nsc.sh)"
cd /opt/rapid7/nexpose/nse
./nse.sh
#tail -f /dev/null