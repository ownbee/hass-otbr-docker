ARG ARCH_PREFIX
FROM homeassistant/${ARCH_PREFIX}-addon-otbr AS base
FROM base

COPY rootfs /
