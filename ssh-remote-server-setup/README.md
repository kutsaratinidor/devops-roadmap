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