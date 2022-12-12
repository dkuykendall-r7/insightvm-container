#!/bin/bash
INSTALLER_RESOURCE_URI="https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin"
INSTALLER_RESOURCE_PATH="/tmp/Rapid7Setup-Linux64.bin"
INSTALLER_RESOURCE_TIMESTAMP="${INSTALLER_RESOURCE_PATH}-timestamp"
echo "INSTALLER_RESOURCE_TIMESTAMP: $INSTALLER_RESOURCE_TIMESTAMP"
echo "Checking if there have been updates to  the installer since the base image was created"

if [[ "${FORCE_DOWNLOAD:-no}" != "yes" && -f "${INSTALLER_RESOURCE_TIMESTAMP}" ]];
then
    LAST_MODIFIED_CURRENT=$(curl -s -v --head "${INSTALLER_RESOURCE_URI}" 2>&1 | grep "^< Last-Modified:")
    LAST_MODIFIED_PREVIOUS=$(cat "${INSTALLER_RESOURCE_TIMESTAMP}")

    echo "LAST_MODIFIED_CURRENT: $LAST_MODIFIED_CURRENT || LAST_MODIFIED_PREVIOUS: $LAST_MODIFIED_PREVIOUS"

    if [[ "${LAST_MODIFIED_CURRENT}" != "${LAST_MODIFIED_PREVIOUS}" ]];
    then
        rm -f "${INSTALLER_RESOURCE_PATH}"
        echo "${LAST_MODIFIED_CURRENT}" > "${INSTALLER_RESOURCE_TIMESTAMP}"
        curl --output "${INSTALLER_RESOURCE_PATH}" "${INSTALLER_RESOURCE_URI}"
    elif [[ "${FORCE_BUILD:-no}" != "yes" ]];
    then
        echo "No new updates."
        exit
    fi
else
    echo "Getting the updated installer."
    curl -s -v --head "${INSTALLER_RESOURCE_URI}" 2>&1 | grep "^< Last-Modified:" > "${INSTALLER_RESOURCE_TIMESTAMP}"
    curl --output "${INSTALLER_RESOURCE_PATH}" "${INSTALLER_RESOURCE_URI}"
fi
