# Static Site Server

[Static Site Server](https://roadmap.sh/projects/static-site-server)

## Instructions

### 1. Provision a remote linux server

* Use a cloud provider like DigitalOcean, AWS, or any VPS provider.

* Choose Ubuntu or any preferred Linux distro.

* Make sure you add an SSH key when creating the droplet (optional but more secure).

### 2. SSH into the remote server
```
ssh username@your_server_ip
```
Replace username with your server user (root or ubuntu) and your_server_ip with your actual IP address.

### 3. Install and Configure NGINX
```
sudo apt update
sudo apt install nginx -y
```
Once installed, verify it's working:
```
curl http://localhost
```
Or visit `http://your_server_ip` from your browser.

### 4. Create a Static Website Locally
Make a directory like static-site/ and put your HTML, CSS, and image files inside:
```cpp
static-site/
├── index.html
├── styles.css
└── images/
    └── logo.png
```
Make sure your HTML links to styles.css and images correctly.

### 5. Configure Nginx to Serve Your Site
```
sudo mkdir -p /var/www/static-site
sudo chown -R $USER:$USER /var/www/static-site
```
Edit the default Nginx config:
```
sudo nano /etc/nginx/sites-available/default
```
Replace its content with:
```
server {
    listen 80;
    server_name yourdomain.com; # or use _ or your_server_ip

    root /var/www/static-site;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
Then restart Nginx:
```
sudo nginx -t
sudo systemctl restart nginx
```

### 6. Use rsync to Deploy Your Site

Create a simple deploy.sh in your project folder:
```bash
#!/bin/bash

LOCAL_DIR="./static-site/"
REMOTE_USER="youruser"
REMOTE_HOST="your_server_ip"
REMOTE_PATH="/var/www/static-site"

rsync -avz --delete $LOCAL_DIR ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}
```
Make it executable:
```bash
chmod +x deploy.sh
```
Now run it with:
```bash
./deploy.sh
```

### When using EC2 on AWS - Open Port 80 in Your EC2 Security Group

This is often the step people miss.

* Go to the AWS Console → EC2 → Instances

* Select your instance

*    Scroll down to Security Groups → click the name

*    In the Security Group page, go to Inbound rules

*    Click Edit inbound rules

*    Add a rule like:

        * Type: HTTP

        * Protocol: TCP

        * Port range: 80

        * Source: 0.0.0.0/0 (for public access)

If you want HTTPS later, also add port 443.

### 7. Access the Site via Browser

In your browser, go to:

http://your-ec2-public-ip

To get the public IP:

* Go to the EC2 instance's detail page
* Look for IPv4 Public IP