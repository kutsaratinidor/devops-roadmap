# SSH Remote Server Setup

[SSH Remote Server Setup](https://roadmap.sh/projects/ssh-remote-server-setup)
The goal of this project is to learn and practice the basics of Linux. You are required to setup a remote linux server and configure it to allow SSH connections.

You should be able to use the following command to connect to your server using both SSH keys.

```
ssh -i <path-to-private-key> user@server-ip
```
Also, look into setting up the configuration in ~/.ssh/config to allow you to connect to your server using the following command.

```
ssh <alias>
```

The only outcome of this project is that you should be able to SSH into your server using both SSH keys. Future projects will cover other aspects of server setup and configuration.

Stretch goal: install and configure fail2ban to prevent brute force attacks.

## Instructions

Requirements:
1. A remote host/vps (DigitalOcean, Linode, AWS)
2. OpenSSH server installed on remote host

### Generate SSH Keys
```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_1st_key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_2nd_key
```

## Copy keys to the remote host

### Method 1: Use ssh-copy-id
```
ssh-copy-id -i ~/.ssh/id_rsa_1st_key.pub user@server
ssh-copy-id -i ~/.ssh/id_rsa_2nd_key.pub user@server
```

## Method 2: Manually copy the public keys to the server

Use cat to show the contents of the public key file from where it was generated:
```
cat ~/.ssh/id_rsa_1st_key.pub
```
Output will show a long random string starting with ssh-rsa:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ3GIJzTX7J6zsCrywcjAM/7Kq3O9ZIvDw2OFOSXAFVqilSFNkHlefm1iMtPeqsIBp2t9cbGUf55xNDULz/bD/4BCV43yZ5lh0cUYuXALg9NI29ui7PEGReXjSpNwUD6ceN/78YOK41KAcecq+SS0bJ4b4amKZIJG3JWm49NWvoo0hdM71sblF956IXY3cRLcTjPlQ84mChKL1X7+D645c7O4Z1N3KtL7l5nVKSG81ejkeZsGFzJFNqvr5DuHdDL5FAudW23me3BDmrM9ifUmt1a00mWci/1qUlaVFft085yvVq7KZbF2OP2NQACUkwfwh+iSTP username@hostname
```
If not present, create .ssh folder and authorized_keys file in the user directory on the remote host
```
mkdir -p /home/user_name/.ssh && touch /home/user_name/.ssh/authorized_keys
```
Use an editor to open the authorized_keys file and add the public key string to this file then save.
```
vim /home/user_name/.ssh/authorized_keys
```
## Make sure ssh keys permission is correct.
Private key - Permissions: 600 (read/write for owner only)
```
chmod 600 ~/.ssh/id_rsa
```
Public key - Permissions: 644 (readable by others, but only you can write)
```
chmod 644 ~/.ssh/id_rsa.pub
```
SSH directory (~/.ssh/) - Permissions: 700 (only the owner can read/write/execute)
```
chmod 700 ~/.ssh
```
## Test ssh connection with your public key
```
ssh -i ~/.ssh/id_rsa_1st_key.pub user@server
```

## Change SSH Config to allow only access with keys

```sh
sudo nano /etc/ssh/sshd_config
```
Changer to match below

```sh
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
```

## Restart SSH Service on Server(Remote Host)

```sh
sudo systemctl restart ssh
```

## Allow simple connection

to use `ssh connection` on local machine create and edit `~/.ssh/config`

```sh
# Config for first key
Host connect
  HostName server
  User user
  IdentityFile ~/.ssh/id_rsa_1st_key
```

---

## To configure Fail2Ban 

1. **Install Fail2Ban**:

   ```bash
   sudo apt update
   sudo apt install fail2ban
   ```

2. **Configure Fail2Ban**:

   - Copy the default config:
     ```bash
     sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
     ```

   - Edit the config to enable SSH protection:
     ```bash
     sudo vim /etc/fail2ban/jail.local
     ```

     In the `[sshd]` section, ensure it looks like this:

     ```ini
     [sshd]
     enabled = true
     maxretry = 5
     bantime = 10m
     findtime = 10m
     ```

4. **Start Fail2Ban**:

   ```bash
   sudo systemctl start fail2ban
   sudo systemctl enable fail2ban
   ```

6. **Check Fail2Ban Status**:

   ```bash
   sudo fail2ban-client status sshd
   ```