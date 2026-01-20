ARG ARCH_PREFIX
FROM homeassistant/${ARCH_PREFIX}-addon-otbr AS base
FROM base

COPY rootfs /
RUN chmod -R +x /etc/s6-overlay/
