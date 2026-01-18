# DNS Server Configuration for FTP Infrastructure

This project documents the complete configuration of a DNS server to resolve the hostnames for an FTP infrastructure under the domain `sistema.sol`. The DNS server is responsible for resolving hostnames related to both the anonymous FTP server and the secure FTP server.

## Scenario

The infrastructure consists of two FTP servers:

1. **Anonymous FTP Server**: Accessible via the hostname `mirror.sistema.sol`, with IP address `192.168.56.10`.
2. **Secure FTP Server**: Accessible via the hostname `ftp.sistema.sol`, with IP address `192.168.56.20`.

The DNS server is configured with IP `192.168.56.5` and is responsible for resolving hostnames related to these services, as well as the server DNS itself under the name `dns.sistema.sol`.

### Requirements

* **BIND9**: Installation and configuration of the DNS service.
* BIND9 configuration files:

  * `/etc/bind/named.conf`
  * `/etc/bind/named.conf.local`
  * `/etc/bind/named.conf.options`
  * Forward zone file: `/etc/bind/db.sistema.sol`
  * Reverse zone file.

### IP Addresses and Hostnames

* **DNS Server**:

  * Hostname: `dns.sistema.sol`
  * IP: `192.168.56.5`
* **Anonymous FTP Server**:

  * Hostname: `mirror.sistema.sol`
  * IP: `192.168.56.10`
* **Secure FTP Server**:

  * Hostname: `ftp.sistema.sol`
  * IP: `192.168.56.20`

### Tools Used

* **BIND9**: For DNS server configuration.
* **named-checkconf**: To verify BIND9 configuration.
* **named-checkzone**: To validate zone files.
* **dig** and **nslookup**: DNS query tools to verify hostname resolution.

## Configuration Steps

1. **Install BIND9**:
   On the DNS server, install the BIND9 package:

    ```bash
        sudo apt update
        sudo apt install bind9
    ```

2. **Configure BIND9 Files**:

   * **`/etc/bind/named.conf`**:
     Includes the zone files and global options.

    ```bash
        include "/etc/bind/named.conf.local";
        include "/etc/bind/named.conf.options";
    ```

   * **`/etc/bind/named.conf.local`**:
     Defines the forward zone for the `sistema.sol` domain.

    ```bash
        zone "sistema.sol" {
            type master;
            file "/etc/bind/db.sistema.sol";
        };

        zone "56.168.192.in-addr.arpa" {
            type master;
            file "/etc/bind/db.56.168.192";
        };
    ```

   * **`/etc/bind/named.conf.options`**:
     Configures global options for the server, such as forwarding queries.

    ```bash
        options {
            directory "/var/cache/bind";

            listen-on { any; };
            allow-query { 192.168.56.0/24; };

            recursion yes;
            forwarders {
                8.8.8.8;
                8.8.4.4;
            };
            dnssec-validation auto;

            auth-nxdomain no;
            listen-on-v6 { none; };
        };
    ```

3. **Zone File**: **`/etc/bind/db.sistema.sol`**

    ```bash
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
    ```

4. **Reverse Zone File**: **`/etc/bind/db.56.168.192`**

    ```bash
        $TTL    604800
        @       IN      SOA     dns.sistema.sol. admin.sistema.sol. (
                                    2026011801 ; Serial
                                    604800     ; Refresh
                                    86400      ; Retry
                                    2419200    ; Expire
                                    604800 )   ; Negative Cache TTL
        ;
        @       IN      NS      dns.sistema.sol.

        5       IN      PTR     dns.sistema.sol.
        10      IN      PTR     mirror.sistema.sol.
        20      IN      PTR     ftp.sistema.sol.
    ```

5. **Restart the DNS Service**:
   After making the necessary configurations, the BIND9 service is restarted to apply the changes, it can be done also manually with:

    ```bash
        sudo systemctl restart bind9
        sudo systemctl enable bind9
    ```

## Configuration Verification

To verify that everything is set up correctly, the following tests were performed:

1. **Check Configuration Files**:
   The following tools were used to ensure there are no errors in the BIND9 configuration:

   * Check the overall configuration:

    ```bash
        named-checkconf
    ```

   * Verify the `sistema.sol` zone:

    ```bash
        named-checkzone sistema.sol /etc/bind/db.sistema.sol
    ```

2. **Name Resolution Tests**:
   From a client machine or the server itself, the following queries were executed:

   * Check resolution for `dns.sistema.sol`:

    ```bash
        dig dns.sistema.sol
        # Or
        nslookup dns.sistema.sol
    ```

   * Check resolution for `mirror.sistema.sol`:

    ```bash
        dig mirror.sistema.sol
        # Or
        nslookup mirror.sistema.sol
    ```

   * Check resolution for `ftp.sistema.sol`:

    ```bash
        dig ftp.sistema.sol
        # Or
        nslookup ftp.sistema.sol
    ```

   The expected results are:

   * **dns.sistema.sol** → `192.168.56.5`
   * **mirror.sistema.sol** → `192.168.56.10`
   * **ftp.sistema.sol** → `192.168.56.20`

3. **Check DNS Service Status**:
   Ensure the DNS service is running and listening on the correct ports:

    ```bash
        sudo systemctl status bind9
        sudo netstat -tuln | grep :53
    ```

## Expected Results

1. The DNS server should resolve the hostnames correctly:

   * `dns.sistema.sol` → `192.168.56.5`
   * `mirror.sistema.sol` → `192.168.56.10`
   * `ftp.sistema.sol` → `192.168.56.20`

2. The DNS service should be running and enabled to start on boot.

3. The configuration files should pass validation using `named-checkconf` and `named-checkzone`.

4. The DNS server should be authoritative for the `sistema.sol` domain.

## Conclusion

This project sets up a DNS server using BIND9 for the FTP infrastructure under the domain `sistema.sol`. With this configuration, the DNS server is able to correctly resolve the hostnames for both the anonymous and secure FTP servers, ensuring that client machines can access them without issues.
