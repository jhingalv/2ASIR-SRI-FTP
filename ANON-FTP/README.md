# Anonymous FTP Server - Classroom Project

## Overview

This project implements an **anonymous FTP server** for OpenSUSE system updates. The server is deployed using **Vagrant** for the infrastructure and **Ansible** for provisioning. The base operating system installed on the server is **Debian**, with the hostname `mirror.sistema.sol`.

The purpose of this project is to provide a classroom example of configuring an anonymous FTP server with specific restrictions and guidelines.

## Configuration

### General Settings

- The FTP server will display a **welcome message**:

```bash
-- Mirror for OpenSUSE for 'sistema.sol' --
```

- Only **IPv4 connections** are allowed.
- **Anonymous users** are the only allowed users.
- **Local users are denied access**.

### User Experience

- Upon login, anonymous users will see a `README.md` file with the following information:

```markdown
-- Anonymous Server --

* Maximum of 200 simultaneous connections
* Bandwidth limit: 50KB per user
* Inactivity timeout: 30 seconds
* Anonymous users have no write permissions
````

### Limits and Restrictions

- **Maximum simultaneous connections:** 200
- **Maximum bandwidth per user:** 50KB
- **Inactivity timeout:** 30 seconds
- **Write permissions:** Not allowed for anonymous users

### Notes

- All configuration files include **comments** explaining the purpose of each setting.
- The setup ensures a controlled and secure environment for providing system updates via FTP.

## Deployment

1. Install **Vagrant** and **Ansible** on your local machine.

2. Start the virtual machine with Vagrant

    ```bash
        vagrant up
    ````

3. Provision the VM using Ansible

    ```bash
        ansible-playbook -i inventory setup.yml
    ```

4. Access the FTP server using any standard FTP client with anonymous login:

    ```bash
        Host: mirror.sistema.sol
        User: anonymous
        Password: <your email>
    ```

## License

This project is licensed under the terms specified in the **[LICENSE](../LICENSE)** file.
