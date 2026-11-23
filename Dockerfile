FROM ghcr.io/home-assistant/app-openthread-border-router:3.4.0 AS base
FROM base

COPY rootfs /
