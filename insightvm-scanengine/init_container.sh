#!/bin/bash
DATADIR="/opt/rapid7/persistent_data"
echo "CONTAINER NOTICE: Checking if this is a first time launch"
if [ "$(ls -A $DATADIR)" ]; then
    echo "CONTAINER NOTICE: Data in place, continue launching..."

else
    echo "CONTAINER NOTICE: Looks like the first run, will move default data files into place."
    mv /opt/rapid7/default_data/* /opt/rapid7/persistent_data/
    echo "CONTAINER NOTICE: Data is now in place, continue launching..."

    
fi
echo "CONTAINER NOTICE: Cleaning up default data"
rm -rf /opt/rapid7/default_data/

echo "CONTAINER NOTICE: Link persistent data paths"
cd /opt/rapid7
ln persistent_data/nse-conf       nexpose/nse/conf
ln persistent_data/nse-keystores  nexpose/nse/keystores






echo "CONTAINER NOTICE: Ready to launch Nexpose Console (./nsc.sh)"
cd /opt/rapid7/nexpose/nse
./nse.sh
tail -f /dev/null
#script /dev/null
#screen ./nse.sh
