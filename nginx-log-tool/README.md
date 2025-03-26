# NGINX Analyzer Tool

This project is part of [roadmap.sh](https://roadmap.sh/projects/nginx-log-analyser) DevOps projects.

The goal of this project is to help you practice some basic shell scripting skills. You will write a simple tool to analyze logs from the command line.

Download the sample nginx access log file from here. The log file contains the following fields:

    IP address
    Date and time
    Request method and path
    Response status code
    Response size
    Referrer
    User agent

You are required to create a shell script that reads the log file and provides the following information:

    Top 5 IP addresses with the most requests
    Top 5 most requested paths
    Top 5 response status codes
    Top 5 user agents

### Step 1: Make the script executable
Before running the script, you need to grant executable permission to nginx-log-tool.sh:

```sh
chmod +x nginx-log-tool.sh
```

### Step 2: 
Once the script has execution permission, you can run it using the command:

```sh
./nginx-log-tool.sh <nginx access log file>
```