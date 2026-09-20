ARG ARCH_PREFIX
FROM homeassistant/${ARCH_PREFIX}-addon-otbr:3.2.0 AS base
FROM base

COPY rootfs /

# Make sure the s6-overlay scripts are executable regardless of whether the
# build context preserved the executable bit (e.g. after a checkout/transfer
# that strips it).
RUN find /etc/s6-overlay -type f -exec chmod +x {} +
