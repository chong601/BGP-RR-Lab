# phase 1 - VyOS configuration
set system host-name AS64520-RR-01
set system name-server 8.8.8.8
set system name-server 8.8.4.4

# phase 2 - interface configuration
set interfaces ethernet eth0 vif address 172.28.0.1/24
set interfaces ethernet eth14 address /24
set interfaces ethernet eth15 address /24

# phase 3 - OSPF

# phase 4 - BGP
