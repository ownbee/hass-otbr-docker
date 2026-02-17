# Home Assistant: Docker OpenThread Border Router

Stand-alone Home Assistant OpenThread Border Router docker container. For containerized home
assistance setup without Yellow or HassOS.

This is a docker container based on the Home Assistant OpenThread Border Router add-on
(https://github.com/home-assistant/addons/tree/master/openthread_border_router) to get the patches
and quirks that the hass team has made. It is the same without the bashio stuff that communicates
with home assistance instance in some way. Just to make the container work stand-alone.

Tested with [Home Assistant Connect ZBT-1](https://www.home-assistant.io/connectzbt1/). Only tested
with Aqara U200 Lock as it is the only Thread device I've got so far.


Disclaimer: I am completely new to IPv6 and Thread so I don't fully know what I am doing here. Just
read documentation and forum threads and eventually got it working using this setup.

## Prerequisite

1. It did not work until I turned on IPv6 on my LAN (without ISP involved). I use Unifi networking
   hardware so I enabled static IPv6 in the Unifi Controller for the Default network:
    * Used https://unique-local-ipv6.com/# for generating a local IPv6 subnet and added ":0001" as
      gateway address. For example: `fda1:1c14:16ac:0001::/64` (starting `fd` means local).
    * Configured SLAAC and enabled IPv6 DNS server.
    * IPv6 on WAN interface disabled.
    * Also enabled mDNS and IGMP snooping on the Default network.
2. Configured the docker host with the following sysctl:

    ```
    net.ipv6.conf.all.disable_ipv6 = 0
    net.ipv4.conf.all.forwarding = 1
    net.ipv6.conf.all.forwarding = 1
    net.ipv6.conf.all.accept_ra_rt_info_max_plen = 64
    net.ipv6.conf.all.accept_ra = 2
    ```
3. Flash the OpenThreadRCP firmware on the Home Assistant Connect ZBT-1 stick. I used the python
   flasher and the latest v2.4.0.0 firmware.

    * Firmware repo: https://github.com/NabuCasa/silabs-firmware
    * Python flasher: https://github.com/NabuCasa/universal-silabs-flasher


## Setup

1. Start this `ghcr.io/ownbee/hass-otbr-docker` container, see the docker-compose file and modify the environment variables
   according to you environment. The env variables are mapped from the addon config to these env
   variables:

    | ENV VARIABLE       | Description                                            |
    |--------------------|--------------------------------------------------------|
    | DEVICE             | Serial port where the OpenThread RCP Radio is attached |
    | BAUDRATE           | Serial port baudrate (depends on firmware)   |
    | FLOW_CONTROL (1 or 0) | If hardware flow control should be enabled (depends on firmware) |
    | AUTOFLASH_FIRMWARE (1 or 0) | Automatically install/update firmware (Home Assistant SkyConnect/Yellow) |
    | OTBR_LOG_LEVEL     | Set the log level of the OpenThread BorderRouter Agent (debug,info,notice,warning,error,critical,alert,emergency)    |
    | OTBR_REST_ADDRESS  | Address to listen on (e.g. `127.0.0.1`). Default is all interfaces. |
    | OTBR_REST_PORT     | Port for REST API used by home assistant |
    | OTBR_WEB (1 or 0)  | Enable or disable WEB UI |
    | OTBR_WEB_ADDRESS   | Address to listen on (e.g. `127.0.0.1`). Default is all interfaces. |
    | OTBR_WEB_PORT      | Port for WEB UI |
    | FIREWALL (1 or 0)  | Enable OpenThread Border Router firewall to block unnecessary traffic |
    | NAT64 (1 or 0)     | Enable NAT64 to allow Thread devices accessing IPv4 addresses |
    | NETWORK_DEVICE     | IP address and port to connect to a network-based RCP (NOT TESTED) |
    | BACKBONE_IF        | Host network interface to use (e.g. eth0, wlan0, enp3s0) |
    | THREAD_1_4         | Define (e.g. set to '1') to enable Thread 1.4 (beta) |

3. Install the `Open Thread Border Router`, `Thread` and `Matter` integrations in your home assistance instance.

4. Integrations -> Open Thread Border Router, and add your border router container that you just
   started. I used "http://<HOST_IP>:8081".

5. Go to Integrations -> Thread -> Configure and add the OTBR network, it should pop-up after the
   last step. Click "Make as preferred", "Reset Border router" and Enable Android/IOS commissioning.

6. You might have to go to https://<YOUR_HASS_URL>`/config/matter/dashboard` and "SET THREAD
   CREDENTIALS" to the dataset found with clicking the "i" in your Thread integration. Unclear if
   this is needed.

5. On you Android Phone, go to Settings -> App -> Troubleshooting and click on Sync Thread Auth.

6. Pair a Thread device by scanning the Matter QR-Code with Integrations -> Add Matter device -> New device.

7. The Android based commissioning/pairing took roughly 2-3 minutes but succeeded eventually.

Also see the following documentation for further information:

* https://openthread.io/guides/border-router/docker
* https://github.com/home-assistant/addons/tree/master/openthread_border_router
* https://www.home-assistant.io/integrations/matter
* https://www.home-assistant.io/integrations/thread


# Buy me a coffee

I am using my free time maintaining this at nights while the kids are asleep. Buy me a [ko-fi.com/ownbee](https://ko-fi.com/ownbee) if you like to boost my maintenance motivation and keep me awake.
