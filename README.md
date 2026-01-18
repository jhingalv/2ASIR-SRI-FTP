# 2ASIR-SRI-FTP Project on Linux
**Secure FTP (FTPS) and Anonymous FTP**

# Authors
- Juan Amador Hinojosa Gálvez [jhingal3010@ieszaidinvergeles.org]
- Álvaro Rodríguez Pulido [arodpul3005@ieszaidinvergeles.org]

---

## General Description
This project focuses on the **installation, configuration, and validation of FTP services on Linux** using the **vsftpd** server. It covers two common real-world scenarios:

1. **Anonymous FTP Server**  
   A public download-only FTP server designed as a mirror repository, with strict security and performance limitations.
2. **Secure FTP Server (FTPS)**  
   Authenticated and anonymous access with bandwidth control, directory jailing, connection limits, and encrypted communications.
   
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

✔ Fully implemented  
✔ Tested and validated  
✔ Ready for deployment and evaluation

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











