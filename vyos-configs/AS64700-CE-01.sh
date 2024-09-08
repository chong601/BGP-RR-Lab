# phase 1 - VyOS configuration
set system host-name AS64700-CE-01
set system name-server 8.8.8.8
set system name-server 8.8.4.4
set service ssh

# phase 2 - interface configuration
set interfaces dummy dum0 address 172.28.12.0/32
set interfaces ethernet eth0 address 172.28.2.41/31
set interfaces ethernet eth3 address 172.28.13.1/25
set interfaces bonding bond0 address 172.28.12.128/31
set interfaces bonding bond0 min-links 1
set interfaces bonding bond0 mii-mon-interval 100
set interfaces bonding bond0 mode 802.3ad
set interfaces bonding bond0 lacp-rate fast
set interfaces bonding bond0 hash-policy layer2+3
set interfaces bonding bond0 member interface eth1
set interfaces bonding bond0 member interface eth2

# phase 3 - OSPF
set protocols ospf parameters router-id 172.28.12.0
set protocols ospf passive-interface default
set protocols ospf log-adjacency-changes

set protocols ospf interface dum0 area 0
set protocols ospf interface bond0 area 0
set protocols ospf interface eth3 area 0

set protocols ospf interface bond0 passive disable

set protocols ospf interface bond0 network point-to-point

# phase 4 - BGP
set protocols bgp system-as 64700

# standard BGP parameter tuning per recommendation by APNIC
set protocols bgp parameters router-id 172.28.12.0
set protocols bgp parameters distance global external 200
set protocols bgp parameters distance global internal 200
set protocols bgp parameters distance global local 200
set protocols bgp parameters deterministic-med

# iBGP neighbors
set protocols bgp neighbor 172.28.12.1 remote-as 64700
set protocols bgp neighbor 172.28.12.1 update-source dum0
set protocols bgp neighbor 172.28.12.1 address-family ipv4-unicast

# eBGP neighbors
set protocols bgp neighbor 172.28.2.40 remote-as 64520
set protocols bgp neighbor 172.28.2.40 address-family ipv4-unicast

# network to advertise to BGP peers
set protocols bgp address-family ipv4-unicast network 172.28.12.0/24
set protocols static route 172.28.12.0/24 blackhole
set protocols bgp address-family ipv4-unicast network 172.28.13.0/25
set protocols static route 172.28.13.0/24 blackhole