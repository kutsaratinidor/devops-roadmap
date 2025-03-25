#!/bin/bash

# Paths and filename configs
ARCHIVE_DIR="./archived_logs"
LOG_FILE="./log_archiver.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Input checking
echo "Log Archiver Tool"
if [ -z "$1" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR="$1"

# Add verbose start
echo "📁 Log directory: $LOG_DIR"
echo "🗃️  Archive directory: $ARCHIVE_DIR"
echo "🕒 Timestamp: $TIMESTAMP"

# Check if log dir input exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: '$LOG_DIR' is not a directory or doesn't exist."
    exit 1
fi

echo "Directory check passed."

# Create archive directory if it does not exist
if [ ! -d "$ARCHIVE_DIR" ]; then
    echo "Archive directory does not exist. Creating: $ARCHIVE_DIR"
    mkdir -p "$ARCHIVE_DIR"
else
    echo "Archive directory already exists."
fi

# Build archive path
ARCHIVE_NAME="logs_archive_$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"
echo "Archive file will be: $ARCHIVE_PATH"


# Compress logs
echo "Compressing logs from $LOG_DIR ..."
if tar --ignore-failed-read -czf "$ARCHIVE_PATH" -C "$LOG_DIR" . 2>> "$LOG_FILE"; then
    echo "Logs compressed and saved to: $ARCHIVE_PATH"
else
    echo "Compression failed!"
    exit 1
fi

# Log operation result in log file
echo "Logging archive event to $LOG_FILE"
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived $LOG_DIR to $ARCHIVE_PATH" >> "$LOG_FILE"

echo "Done!"
