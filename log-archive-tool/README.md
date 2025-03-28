# Log Archive Tool

This project is part of [roadmap.sh](https://roadmap.sh/projects/log-archive-tool) DevOps projects.

In this project, you will build a tool to archive logs on a set schedule by compressing them and storing them in a new directory, this is especially useful for removing old logs and keeping the system clean while maintaining the logs in a compressed format for future reference. This project will help you practice your programming skills, including working with files and directories, and building a simple cli tool.

The most common location for logs on a unix based system is /var/log.
Requirements

The tool should run from the command line, accept the log directory as an argument, compress the logs, and store them in a new directory. The user should be able to:

    Provide the log directory as an argument when running the tool.

    log-archive <log-directory>

    The tool should compress the logs in a tar.gz file and store them in a new directory.
    The tool should log the date and time of the archive to a file.

    logs_archive_20240816_100648.tar.gz

## Usage 

### Step 1: Make the script executable
Before running the script, you need to grant executable permission to log-archive-tool.sh:

```sh
chmod +x log-archive-tool.sh
```

### Step 2: 
Once the script has execution permission, you can run it using the command:

```sh
./log-archive-tool.sh <path to log directory>
```

### Notes:
Logs will be stored in the current directory under archived_logs folder. It will be created by the script if it does not exist. 
Record of the operation will be logged in log_archiver.log