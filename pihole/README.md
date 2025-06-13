# Pi-hole

Pi-hole is being used for blocking unused DNS traffic and for Ad blocking.

In addition, a private domain (`smart.home`) is also being created. The entries for for the name resultion are mentioned in the `docker-compose.yml` file.

Pi-hole is also running as Docker Container and the deployment is done with the `docker-compose.yml` file.

As DNS servers, the public Telekom DNS servers are used:

```
194.25.0.68
194.25.0.52
```

So that the Pi-hole can function as the DNS server, the IP of the Raspberry PI have to be added into the Fritz.Box under:

- Internet > Acess credentials > DNS server > enter IP of Raspberry Pi into `DNSv4 server`
- Home network > Network settings > more settings > IPv4 settings > enter IP of Raspberry Pi into `local DNS server`

## Used Adlists

- https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
- https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
- https://v.firebog.net/hosts/AdguardDNS.txt
- https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
- https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts
- https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/notserious
- https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Phishing-Angrifferiffe
- https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/spam.mails
- https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/crypto
- https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/easylist


## Helpful links:

https://discourse.pi-hole.net/t/solve-dns-resolution-in-other-containers-when-using-docker-pihole/31413
