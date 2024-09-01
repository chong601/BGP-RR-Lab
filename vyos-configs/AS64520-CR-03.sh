# phase 1 - VyOS configuration
set system host-name AS64520-CR-03
set system name-server 8.8.8.8
set system name-server 8.8.4.4
set service ssh

# phase 2 - interface configuration
set interfaces dummy dum0 address 172.28.0.4/32
set interfaces ethernet eth0 address 172.28.2.16/31
set interfaces ethernet eth1 address 172.28.2.22/31
set interfaces ethernet eth4 address 172.28.2.11/31
set interfaces ethernet eth5 address 172.28.2.14/31

# phase 3 - OSPF
set protocols ospf parameters router-id 172.28.0.4
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
