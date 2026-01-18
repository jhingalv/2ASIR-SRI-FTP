# 2ASIR-SRI-FTP Project on Linux
**Secure FTP (FTPS) and Anonymous FTP**

# Authors
- Juan Amador Hinojosa Gálvez [jhingal3010@ieszaidinvergeles.org]
- Álvaro Rodríguez Pulido [arodpul3005@ieszaidinvergeles.org]

---

## General Description
This project focuses on the **installation, configuration, and validation of FTP services on Linux** using the **vsftpd** server. It covers two common real-world scenarios with a DNS server configuration for both cases:

1. **Anonymous FTP Server**  
   A public download-only FTP server designed as a mirror repository, with strict security and performance limitations.
2. **Secure FTP Server (FTPS)**  
   Authenticated and anonymous access with bandwidth control, directory jailing, connection limits, and encrypted communications.
3. **DNS server**
   Responsible for resolving the hostnames required for the FTP infraestructure in sistema.sol domain.
Each subproject includes setup steps, configuration requirements, testing procedures, and validation criteria.

---

## Project Structure
```text
ANON-FTP/
├── ansible/
│ ├── files/
│ │ ├── README.md
│ │ └── vsftpd.conf
│ └── playbook.yml
└── README.md

LICENSE

README.md

Vagrantfile

inventory.ini
```

---

## Subproject 1: Anonymous FTP Server

### Objectives
- Configure a **pure anonymous FTP server** for publis downloads
- Provide a mirror repository for **OpenSUSE updates**
- Prevent any authenticated local user access

---

### Server Information  
- Operating System: **Debian**
- Hostname: **mirror.sistema.sol**
- IP address: 192.168.56.10

---

### Configuration Requirements
- All configuration directives documented with comments
- Welcome message: **-- Mirror of OpenSUSE for 'sistema.sol'**
- IPV4 only
- Only anonymous users allowed
- Local users explicitly denied
- Display an informational message upon login with the following content:
  ```text
  -- Servidor anónimo
  -- Máximo de 200 conexiones activas simultáneas.
  -- Ancho de banda de 50KB por usuario
  -- Timeout de inactividad de 30 segundos
  --
  ```

---

### Security and Performance Limits
- Anonymous users have **no write permissions**
- Maximum of **200 simultaneous connections**
- Bandwidth limit per user: **50 KB/s**
- Idle timeout: **30 seconds**

---

### Validation
- Anonymous login only
- No upload
- Automatic disconnection after inactivity
- Proper enforcement of connection and bandwidth limits

---

## Tools Used

- **vsftpd**
- FTP command-line client (`ftp`, `pftp`)
- Graphical FTP clients:
- FileZilla
- gFTP
- WinSCP
- OpenSSL (certificate generation)

---

## Learning Outcomes

- FTP vs FTPS operation
- Active and passive FTP modes
- Anonymous FTP configuration
- User isolation and security
- Bandwidth and connection control
- SSL/TLS encryption in vsftpd

---

## Project Status

- ✔ Fully implemented  
- ✔ Tested and validated  
- ✔ Ready for deployment and evaluation

---

## Subproject 2: Secure FTP (FTPS)

### Objectives

- Deploy a **secure vsftpd server** on Linux.
- Allow access for:
  - Local authenticated users
  - Anonymous users (read-only)
- Implement:
  - SSL/TLS encryption
  - Bandwidth limits
  - Directory jailing (`chroot`)
  - Connection limits
  - Custom welcome messages

---

### Server Information  
- Operating System: **Debian**
- Hostname: **ftp.sistema.sol**
- IP address: 192.168.56.20

---

### Main Features

- **Standalone mode (IPv4 only)**
- FTP server welcome message: **--- Welcome to the FTP server of 'sistema.sol'---**
- Additional message for anonymous users: **---You have accessed the public directory server of 'sistema.sol'---**
- Data connection port: **20**
- Idle timeout: **720 seconds**
- Maximum of **15 simultaneous connections**
- Bandwidth limits:
- Local users: **5 MB/s**
- Anonymous users: **2 MB/s**

---

###  User Management

| User       | Access | Upload | Chroot Jail |
|------------|--------|--------|-------------|
| anonymous  | Yes    | ❌     | Yes         |
| luis       | Yes    | ✅     | Yes         |
| maria      | Yes    | ✅     | ❌          |
| miguel~    | Yes    | ✅     | Yes         |

---

###  FTPS Security Configuration

- Server certificate location: **/etc/ssl/certs/example.test.pem**
- Encrypted login and data transfer required for local users
- Supported protocols:
- SSLv3
- TLS
- Anonymous users: encryption optional
- Compatibility option for some FTPS clients: require_ssl_reuse=NO


---

###  Validation and Testing

- Anonymous FTP connection using command-line client
- Authenticated FTP access:
- `maria` (not jailed in home directory)
- `luis` (jailed in home directory)
- Secure FTPS connection using a graphical client
- Certificate acceptance and verification
- Secure file download confirmation (lock icon displayed in client)

---

## Subproject 3: DNS Server

### Overview
This virtual machine implements the **DNS infrastructure** for the `sistema.sol` domain.  
It provides name resolution services required by the FTP environment, including both the **anonymous FTP server** and the **secure FTP server**.

The DNS service is implemented using **BIND9** and is authoritative for the `sistema.sol` domain.

---

### Server Information

| Item | Value |
|-----|------|
| Hostname | `dns.sistema.sol` |
| IP Address | `192.168.56.5` |
| Service | DNS (BIND9) |
| Domain | `sistema.sol` |

---

### DNS Responsibilities

This DNS server is responsible for resolving hostnames related to the FTP infrastructure:

| Hostname | Purpose | IP Address |
|--------|--------|------------|
| `dns.sistema.sol` | DNS server | `192.168.56.5` |
| `mirror.sistema.sol` | Anonymous FTP server | `192.168.56.10` |
| `ftp.sistema.sol` | Secure FTP server | `192.168.56.20` |

---

### Installed Software

- **bind9** – DNS server software
- **dnsutils** – DNS query and troubleshooting tools

---

### Configuration Files

The DNS configuration is handled through the following files:

| File | Purpose |
|----|--------|
| `/etc/bind/named.conf` | Main BIND configuration file |
| `/etc/bind/named.conf.options` | Global DNS options |
| `/etc/bind/named.conf.local` | Local zone definitions |
| `/etc/bind/db.sistema.sol` | Forward zone file for `sistema.sol` |
| Reverse zone file | IP-to-hostname resolution (optional but recommended) |

---

### Forward DNS Zone

A forward DNS zone for the domain `sistema.sol` is configured and includes the following **A records**:

```text
dns.sistema.sol     → 192.168.56.5
mirror.sistema.sol  → 192.168.56.10
ftp.sistema.sol     → 192.168.56.20
```

### Service Status
- DNS service is running and enabled at system startup
- Listening on port 53 (UDP and TCP)
- Accessible from client machines within the network

### Validation and Testing
The configuration was validated using the following tools:
**Configuration Validation**
```bash
named-checkconf
named-checkconf sistema.sol /etc/bind/db.sistema.sol
```
**Name Resolution Tests**
```bash
dig dns.sistema.sol
dig mirror.sistema.sol
dig ftp.sistema.sol

nslookup dns.sistema.sol
nslookup mirror.sistema.sol
nslookup ftp.sistema.sol
```
The tests should return the expected IP addresses

### Expected Results
- The DNS server responds as dns.sistema.sol with IP 192.168.56.5
- Forward DNS zone for sistema.sol is correctly defined
- All required A records exists and resolve correctly
- DNS service starts automatically on boot
- The DNS infraestructure fully supports the FTP services

### Completion Criteria
- ✔ bind9 package installed
- ✔ DNS service running and enabled
- ✔ sistema.sol zone defined without errors
- ✔ A records for dns, mirror, and ftp correctly configured
- ✔ Configuration passes named-checkconf and named-checkzone
- ✔ Name resolution works from client machines
- ✔ DNS server is authoritative for sistema.sol


