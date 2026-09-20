#!/usr/bin/with-contenv bash
# shellcheck shell=bash
# ==============================================================================
# Home Assistant Community Add-on: Base Images
# Displays a simple add-on banner on startup
# ==============================================================================
echo '-----------------------------------------------------------'
echo " Homeassistant version of OpenThread Border Router"
echo " Dockerized add-on: ownbee/hass-otbr-docker"
echo '-----------------------------------------------------------'

echo " System: $(uname -nms)"

echo '-----------------------------------------------------------'
echo ' Please, share the above information when looking for help'
echo ' or support in, e.g., GitHub, forums or the Discord chat.'
echo '-----------------------------------------------------------'
