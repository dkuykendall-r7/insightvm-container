#!/bin/bash
INSTALLER_RESOURCE_URI="https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin"
INSTALLER_RESOURCE_PATH="/tmp/Rapid7Setup-Linux64.bin"
INSTALLER_RESOURCE_TIMESTAMP="${INSTALLER_RESOURCE_PATH}-timestamp"

LAST_MODIFIED_CURRENT=$(curl -s -v --head "${INSTALLER_RESOURCE_URI}" 2>&1 | grep "^< Last-Modified:")
echo "${LAST_MODIFIED_CURRENT}" > "${INSTALLER_RESOURCE_TIMESTAMP}"
