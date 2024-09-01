# phase 1 - VyOS configuration
set system host-name AS64520-BR-01
set system name-server 8.8.8.8
set system name-server 8.8.4.4
set service ssh

# phase 2 - interface configuration
set interfaces dummy dum0 address 172.28.0.0/32
set interfaces ethernet eth0 vif 40 address 192.168.110.2/24
set interfaces ethernet eth1 address 172.28.2.0/31
set interfaces ethernet eth2 address 172.28.2.6/31

# phase 2.5 - default route
set protocols static route 0.0.0.0/0 next-hop 192.168.110.1

# phase 3 - OSPF
set protocols ospf parameters router-id 172.28.0.0
set protocols ospf passive-interface default
set protocols ospf log-adjacency-changes

set protocols ospf interface dum0 area 0
set protocols ospf interface eth1 area 0
set protocols ospf interface eth2 area 0

set protocols ospf interface eth1 passive disable
set protocols ospf interface eth2 passive disable

set protocols ospf interface eth1 network point-to-point
set protocols ospf interface eth2 network point-to-point

set protocols ospf default-information originate

# phase 4 - BGP
