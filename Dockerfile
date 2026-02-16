ARG ARCH_PREFIX
FROM homeassistant/${ARCH_PREFIX}-addon-otbr:2.16.3 AS base
FROM base

COPY rootfs /
