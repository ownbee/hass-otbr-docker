FROM ghcr.io/home-assistant/app-openthread-border-router:3.4.0 AS base
FROM base

COPY rootfs /

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD ot-ctl state | grep -qE '^(leader|router|child)' || exit 1
