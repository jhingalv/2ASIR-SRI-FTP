$TTL    604800
@       IN      SOA     dns.sistema.sol. admin.sistema.sol. (
                              2026011801 ; Serial
                              604800     ; Refresh
                              86400      ; Retry
                              2419200    ; Expire
                              604800 )   ; Negative Cache TTL
;
@       IN      NS      dns.sistema.sol.

dns     IN      A       192.168.56.5
mirror  IN      A       192.168.56.10
ftp     IN      A       192.168.56.20
