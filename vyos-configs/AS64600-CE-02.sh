# phase 1 - VyOS configuration
set system host-name AS64600-CE-02
set system name-server 8.8.8.8
set system name-server 8.8.4.4
set service ssh

# phase 2 - interface configuration
set interfaces dummy dum0 address 172.28.8.131/32
set interfaces ethernet eth0 address 172.28.2.37/31
set interfaces ethernet eth1 address 172.28.2.35/31
set interfaces ethernet eth2 address 172.28.8.3/26
set interfaces ethernet eth3 address 172.28.8.67/26
set interfaces bonding bond0 address 172.28.8.129/31
set interfaces bonding bond0 min-links 1
set interfaces bonding bond0 mii-mon-interval 100
set interfaces bonding bond0 mode 802.3ad
set interfaces bonding bond0 lacp-rate fast
set interfaces bonding bond0 hash-policy layer2+3
set interfaces bonding bond0 member interface eth4
set interfaces bonding bond0 member interface eth5

# phase 2.5 - VRRP
set high-availability vrrp group AS64600-DNS-LAN-1 address 172.28.8.1/32
set high-availability vrrp group AS64600-DNS-LAN-1 vrid 1
set high-availability vrrp group AS64600-DNS-LAN-1 authentication password 64600-0
set high-availability vrrp group AS64600-DNS-LAN-1 authentication type plaintext-password
set high-availability vrrp group AS64600-DNS-LAN-1 interface eth2

set high-availability vrrp group AS64600-DNS-LAN-2 address 172.28.8.65/32
set high-availability vrrp group AS64600-DNS-LAN-2 vrid 2
set high-availability vrrp group AS64600-DNS-LAN-2 authentication password 64600-1
set high-availability vrrp group AS64600-DNS-LAN-2 authentication type plaintext-password
set high-availability vrrp group AS64600-DNS-LAN-2 interface eth3

# phase 3 - OSPF
set protocols ospf parameters router-id 172.28.8.131
set protocols ospf passive-interface default
set protocols ospf log-adjacency-changes

set protocols ospf interface dum0 area 0
set protocols ospf interface bond0 area 0

set protocols ospf interface bond0 passive disable

set protocols ospf interface bond0 network point-to-point

# phase 4 - BGP
set protocols bgp system-as 64600

# standard BGP parameter tuning per recommendation by APNIC
set protocols bgp parameters router-id 172.28.8.131
set protocols bgp parameters distance global external 200
set protocols bgp parameters distance global internal 200
set protocols bgp parameters distance global local 200
set protocols bgp parameters deterministic-med

set protocols bgp neighbor 172.28.2.34 remote-as 64520
set protocols bgp neighbor 172.28.2.34 address-family ipv4-unicast
set protocols bgp neighbor 172.28.2.36 remote-as 64520
set protocols bgp neighbor 172.28.2.36 address-family ipv4-unicast

set protocols bgp address-family ipv4-unicast network 172.28.8.0/24
set protocols static route 172.28.8.0/24 blackhole

set protocols bgp neighbor 172.28.8.130 remote-as 64600
set protocols bgp neighbor 172.28.8.130 update-source dum0
set protocols bgp neighbor 172.28.8.130 address-family ipv4-unicast
set protocols bgp neighbor 172.28.8.10 remote-as 64600
set protocols bgp neighbor 172.28.8.10 address-family ipv4-unicast
set protocols bgp neighbor 172.28.8.11 remote-as 64600
set protocols bgp neighbor 172.28.8.11 address-family ipv4-unicast
set protocols bgp neighbor 172.28.8.12 remote-as 64600
set protocols bgp neighbor 172.28.8.12 address-family ipv4-unicast

# make per-request multipath work
# note that this setting may cause ICMP error response to arrive at the
# wrong host due to the kernel not checking the inner packet headers
#
# this setting should ONLY be used on services that can tolerate missing
# ICMP error reponses
set system sysctl parameter net.ipv4.fib_multipath_hash_policy value 1
set system sysctl parameter net.ipv6.fib_multipath_hash_policy value 1
