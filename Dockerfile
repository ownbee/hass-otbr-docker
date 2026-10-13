ARG ARCH_PREFIX
FROM homeassistant/${ARCH_PREFIX}-addon-otbr:3.3.0 AS base
FROM base

COPY rootfs /
