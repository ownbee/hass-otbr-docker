#!/usr/bin/with-contenv bash
# ==============================================================================
# Configure OTBR depending on add-on settings
# ==============================================================================

ot-ctl trel enable

if [ "$NAT64" != "0" ] ; then
    echo "INFO: Enabling NAT64."
    ot-ctl nat64 enable
    ot-ctl dns server upstream enable
fi

# To avoid asymmetric link quality the TX power from the controller should not
# exceed that of what other Thread routers devices typically use.
ot-ctl txpower 6
