# Dockerfile for axonius/tunnel image (Customer need to pass ovpn config file as base64 in OVPN_CONF env variable)
FROM alpine:3.11.6

RUN sed -i 's/http/https/g' /etc/apk/repositories
RUN apk add --no-cache openvpn curl bind-tools vim alpine-sdk linux-headers curl iptables iptables-dev tcptraceroute bash dnsmasq

RUN adduser -H -D axonius
RUN adduser -H -D axonius_admin
RUN addgroup axonius_admin axonius
RUN mkdir /conf
RUN mkdir /resolv
RUN mkdir /scripts

RUN echo -n IyEvYmluL2Jhc2gKaXB0YWJsZXMgLVAgRk9SV0FSRCBBQ0NFUFQKSUZBQ0U9JChyb3V0ZSB8IGdyZXAgJ15kZWZhdWx0JyB8IGdyZXAgLW8gJ1teIF0qJCcpCmlwdGFibGVzIC10IG5hdCAtRgppcHRhYmxlcyAtdCBuYXQgLUEgUE9TVFJPVVRJTkcgLW8gJElGQUNFIC1qIE1BU1FVRVJBREUKaXB0YWJsZXMgLXQgbWFuZ2xlIC1BIFBSRVJPVVRJTkcgLWkgJElGQUNFIC1qIFRUTCAtLXR0bC1zZXQgNjQKCmRuc21hc3EgLS1sb2ctZmFjaWxpdHk9L3RtcC9kbnNtYXNxLmxvZyAtLWludGVyZmFjZT10YXAwIC0tY2FjaGUtc2l6ZT0wIC0tYmluZC1pbnRlcmZhY2VzIC0tbWF4LWNhY2hlLXR0bD0wICYK | base64 -d > scripts/startup.sh
RUN echo -n IyEvYmluL2Jhc2gKa2lsbGFsbCAtOSBkbnNtYXNxCg== | base64 -d > scripts/stop_dnsmasq.sh
RUN echo -n IyEvYmluL2Jhc2gKc3VkbyBta2RpciAtcCAvZGV2L25ldCAmJiBzdWRvIG1rbm9kIC9kZXYvbmV0L3R1biBjIDEwIDIwMAplY2hvIC1uICRPVlBOX0NPTkYgfCBiYXNlNjQgLWQgPiBjb25mL3VzZXIub3ZwbgpzdWRvIG9wZW52cG4gLS1jb25maWcgL2NvbmYvdXNlci5vdnBuIC0tc2NyaXB0LXNlY3VyaXR5IDIgLS11cCAvc2NyaXB0cy9zdGFydHVwLnNoIC0tdXNlciBheG9uaXVzIC0tZ3JvdXAgYXhvbml1cyAtLWRvd24gL3NjcmlwdHMvc3RvcF9kbnNtYXNxLnNoIAo= | base64 -d > scripts/init.sh
RUN echo -n ZWNobyAiYXhvbml1c19hZG1pbiBBTEw9KEFMTCkgTk9QQVNTV0Q6L3Vzci9zYmluL29wZW52cG4iIHwgRURJVE9SPSJ0ZWUgLWEiIHZpc3Vkbw== | base64 -d | /bin/sh
RUN echo -n ZWNobyAiYXhvbml1c19hZG1pbiBBTEw9KEFMTCkgTk9QQVNTV0Q6L2Jpbi9ta2RpciIgfCBFRElUT1I9InRlZSAtYSIgdmlzdWRv | base64 -d | /bin/sh
RUN echo -n ZWNobyAiYXhvbml1c19hZG1pbiBBTEw9KEFMTCkgTk9QQVNTV0Q6L2Jpbi9ta25vZCIgfCBFRElUT1I9InRlZSAtYSIgdmlzdWRv | base64 -d | /bin/sh

RUN chmod +x /scripts/*.sh
RUN chown -R axonius_admin:axonius_admin /scripts && chown -R axonius_admin:axonius_admin /conf

USER axonius_admin
CMD ["/scripts/init.sh"]