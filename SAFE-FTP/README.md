# Secure FTP Server with vsftpd (Linux)

## Project Overview

This project consists of the installation, configuration, and securing of an FTP server using **vsftpd** on Linux. It also includes the use of both **command-line** and **graphical FTP clients**, anonymous and authenticated access, user restrictions (chroot), bandwidth limits, and secure connections using **FTPS (SSL/TLS)**.

The FTP server is hosted on a Linux virtual machine with the following IP address:

- **FTP Server IP:** `192.168.56.20`
- **FTP Hostname:** `ftp.sistema.sol`

---

## 1. Initial Setup

- The same hostnames and IP addressing scheme from previous lab exercises are reused.
- A Linux virtual machine is used as the FTP client and another one as the FTP server.
- A local user named `pepe` is created for FTP client testing.

---

## 2. Command-Line FTP Client Usage

A Linux VM is configured with a command-line FTP client.

### Steps performed:

- Login as user `pepe`
- Create directory: /home/pepe/pruebasFTP
- Create a file `datos1.txt` with custom content
- Connect using the command-line FTP client (`pftp`) to: ftp.cica.es
- Check current server directory
- Check local client directory
- List server files
- List local files
- Download `/pub/check`
- Verify the download locally
- Create directory `img` locally
- Attempt to upload `datos1.txt` (expected to fail for anonymous access)
- Close the FTP connection

---

## 3. Graphical FTP Client Usage

A graphical FTP client such as **FileZilla**, **gFTP**, or **WinSCP** is installed.

### Tasks:

- Create an **anonymous connection** to: ftp.rediris.es
- Analyze the connection messages to determine:
- FTP mode used (Active or Passive)
- Server IP address
- Meaning of the last two numbers in the `227 Entering Passive Mode` message
- Download the file `welcome.msg` into the user's Documents folder

---

## 4. Installation of vsftpd on Linux

The FTP server is installed on a Linux VM with IP `192.168.56.20`.

### Steps:

- Install `vsftpd`
- Verify:
- User `ftp` exists
- Home directory is `/srv/ftp`
- Group `ftp` exists
- Check:
- `/srv/ftp` directory ownership (`root:ftp`)
- List users denied FTP access
- Confirm:
- vsftpd service is running
- Listening on TCP port 21
- Backup configuration file: /etc/vsftpd.conf
- Create local users:
- `luis`
- `maria`
- `miguel`
- Create test files in user home directories:
- `luis1.txt`, `luis2.txt`
- `maria1.txt`, `maria2.txt`

---

## 5. FTP Server Configuration

The default configuration file is cleaned of original comments and replaced with custom documented directives.

### Configuration requirements:

- Standalone mode (IPv4)
- Welcome banner: --- Welcome to the FTP server of 'sistema.sol' ---
- Anonymous welcome message: --- You have accessed the public directory server of 'sistema.sol' ---
- Data connection via port 20
- Idle timeout: **720 seconds**
- Maximum connections: **15**
- Bandwidth limits:
- Local users: **5 MB/s**
- Anonymous users: **2 MB/s**
- Anonymous users:
- Download allowed
- Upload denied
- Local users:
- Upload and download allowed
- Chroot restrictions:
- All users jailed to home directory **except `maria`**
- Verify after restart:
- Service is running
- Listening on port 21/TCP

### Testing:

- Anonymous FTP connection (command-line)
- Authenticated FTP:
- `maria`: not chrooted
- `luis`: chrooted to home directory

---

## 6. Secure FTP Server Configuration (FTPS)

The FTP server is upgraded to support **secure FTP (FTPS)**.

### Security features:

- SSL/TLS encryption enabled
- Server certificate located at: /etc/ssl/certs/example.test.pem
- Encrypted login and data transfer required for authenticated users
- Anonymous users may use encrypted or unencrypted connections
- Compatibility directive enabled: require_ssl_reuse=NO

### Verification:

- Restart vsftpd and verify:
- Service status
- Listening on port 21/TCP
- Test secure connections using a graphical client:
- Authenticated FTPS connection as `luis`
- Accept server certificate
- Download a file
- Verify secure connection (lock icon)
- Test secure anonymous FTPS connection

---

## Validation

This project validates:
- FTP and FTPS client/server interaction
- Secure file transfer using SSL/TLS
- User access control and isolation
- Bandwidth management and server hardening



