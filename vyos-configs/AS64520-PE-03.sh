# phase 1 - VyOS configuration
set system host-name AS64520-PE-03
set system name-server 8.8.8.8
set system name-server 8.8.4.4
set service ssh

# phase 2 - interface configuration
set interfaces dummy dum0 address 172.28.0.8/32
set interfaces ethernet eth0 address 172.28.2.36/31
set interfaces ethernet eth1 address 172.28.2.38/31
set interfaces ethernet eth4 address 172.28.2.27/31
set interfaces ethernet eth5 address 172.28.2.29/31

# phase 3 - OSPF
set protocols ospf parameters router-id 172.28.0.8
set protocols ospf passive-interface default
set protocols ospf log-adjacency-changes

set protocols ospf interface dum0 area 0
set protocols ospf interface eth0 area 0
set protocols ospf interface eth1 area 0
set protocols ospf interface eth4 area 0
set protocols ospf interface eth5 area 0

set protocols ospf interface eth0 passive disable
set protocols ospf interface eth1 passive disable
set protocols ospf interface eth4 passive disable
set protocols ospf interface eth5 passive disable

set protocols ospf interface eth0 network point-to-point
set protocols ospf interface eth1 network point-to-point
set protocols ospf interface eth4 network point-to-point
set protocols ospf interface eth5 network point-to-point

# phase 4 - BGP
set protocols bgp system-as 64520

# standard BGP parameter tuning per recommendation by APNIC
set protocols bgp parameters router-id 172.28.0.8
set protocols bgp parameters distance global external 200
set protocols bgp parameters distance global internal 200
set protocols bgp parameters distance global local 200
set protocols bgp parameters deterministic-med

set protocols bgp neighbor 172.28.0.0 remote-as 64520
set protocols bgp neighbor 172.28.0.0 update-source dum0
set protocols bgp neighbor 172.28.0.0 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.1 remote-as 64520
set protocols bgp neighbor 172.28.0.1 update-source dum0
set protocols bgp neighbor 172.28.0.1 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.2 remote-as 64520
set protocols bgp neighbor 172.28.0.2 update-source dum0
set protocols bgp neighbor 172.28.0.2 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.3 remote-as 64520
set protocols bgp neighbor 172.28.0.3 update-source dum0
set protocols bgp neighbor 172.28.0.3 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.4 remote-as 64520
set protocols bgp neighbor 172.28.0.4 update-source dum0
set protocols bgp neighbor 172.28.0.4 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.5 remote-as 64520
set protocols bgp neighbor 172.28.0.5 update-source dum0
set protocols bgp neighbor 172.28.0.5 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.6 remote-as 64520
set protocols bgp neighbor 172.28.0.6 update-source dum0
set protocols bgp neighbor 172.28.0.6 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.7 remote-as 64520
set protocols bgp neighbor 172.28.0.7 update-source dum0
set protocols bgp neighbor 172.28.0.7 address-family ipv4-unicast nexthop-self
set protocols bgp neighbor 172.28.0.9 remote-as 64520
set protocols bgp neighbor 172.28.0.9 update-source dum0
set protocols bgp neighbor 172.28.0.9 address-family ipv4-unicast nexthop-self

set protocols bgp address-family ipv4-unicast network 172.28.0.0/22
set protocols static route 172.28.0.0/22 blackhole

set protocols bgp neighbor 172.28.2.37 remote-as 64600
set protocols bgp neighbor 172.28.2.37 address-family ipv4-unicast soft-reconfiguration inbound
set protocols bgp neighbor 172.28.2.39 remote-as 64600
set protocols bgp neighbor 172.28.2.39 address-family ipv4-unicast soft-reconfiguration inbound

