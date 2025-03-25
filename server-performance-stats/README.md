# Performance Server Stats 

This project is part of [roadmap.sh](https://roadmap.sh/projects/server-stats) DevOps projects.

Goal of this project is to write a script to analyse server performance stats.
Requirements

You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

    Total CPU usage
    Total memory usage (Free vs Used including percentage)
    Total disk usage (Free vs Used including percentage)
    Top 5 processes by CPU usage
    Top 5 processes by memory usage

Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

## Usage 

### Step 1: Make the script executable
Before running the script, you need to grant executable permission to server-stats.sh:

```sh
chmod +x server-stats.sh
```

### Step 2: Run the script
Once the script has execution permission, you can run it using the command:

```sh
./server-stats.sh
```