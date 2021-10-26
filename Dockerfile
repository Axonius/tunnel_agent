# Dockerfile for axonius/tunnel image (Customer need to pass ovpn config file as base64 in OVPN_CONF env variable)
FROM alpine:3.11.6

RUN sed -i 's/http/https/g' /etc/apk/repositories
RUN apk add --no-cache openvpn curl bind-tools vim alpine-sdk linux-headers curl iptables iptables-dev tcptraceroute bash dnsmasq

RUN mkdir /conf
RUN mkdir /resolv
RUN mkdir /scripts

RUN echo -n IyEvYmluL2Jhc2gKaXB0YWJsZXMgLVAgRk9SV0FSRCBBQ0NFUFQKSUZBQ0U9JChyb3V0ZSB8IGdyZXAgJ15kZWZhdWx0JyB8IGdyZXAgLW8gJ1teIF0qJCcpCmlwdGFibGVzIC10IG5hdCAtRgppcHRhYmxlcyAtdCBuYXQgLUEgUE9TVFJPVVRJTkcgLW8gJElGQUNFIC1qIE1BU1FVRVJBREUKaXB0YWJsZXMgLXQgbWFuZ2xlIC1BIFBSRVJPVVRJTkcgLWkgJElGQUNFIC1qIFRUTCAtLXR0bC1zZXQgNjQKCmRuc21hc3EgLS1sb2ctZmFjaWxpdHk9L3RtcC9kbnNtYXNxLmxvZyAtLWludGVyZmFjZT10YXAwIC0tY2FjaGUtc2l6ZT0wIC0tYmluZC1pbnRlcmZhY2VzIC0tbWF4LWNhY2hlLXR0bD0wICYK | base64 -d > scripts/startup.sh
RUN echo -n IyEvYmluL2Jhc2gKa2lsbGFsbCAtOSBkbnNtYXNxCg== | base64 -d > scripts/stop_dnsmasq.sh
RUN echo -n IyEvYmluL2Jhc2gKbWtkaXIgLXAgL2Rldi9uZXQgJiYgbWtub2QgL2Rldi9uZXQvdHVuIGMgMTAgMjAwCmVjaG8gLW4gJE9WUE5fQ09ORiB8IGJhc2U2NCAtZCA+IGNvbmYvdXNlci5vdnBuCm9wZW52cG4gLS1jb25maWcgL2NvbmYvdXNlci5vdnBuIC0tc2NyaXB0LXNlY3VyaXR5IDIgLS11cCAvc2NyaXB0cy9zdGFydHVwLnNoIC0tZG93biAvc2NyaXB0cy9zdG9wX2Ruc21hc3Euc2gK | base64 -d > scripts/init.sh

RUN chmod +x /scripts/*.sh

CMD ["/scripts/init.sh"]

