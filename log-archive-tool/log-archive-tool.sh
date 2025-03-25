#!/bin/bash

# === Configuration ===
ARCHIVE_DIR="./archived_logs"
LOG_FILE="./log_archiver.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# === Usage Check ===
echo "Log Archiver Tool"
if [ -z "$1" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR="$1"

# === Directory Check ===
if [ ! -d "$LOG_DIR" ]; then
    echo "❌ Error: '$LOG_DIR' is not a directory or doesn't exist."
    exit 1
fi

# === Create Archive Directory if Needed ===
mkdir -p "$ARCHIVE_DIR"

# === Define Archive File Name ===
ARCHIVE_NAME="logs_$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

# === Compress Logs ===
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" . && echo "✅ Archived logs to: $ARCHIVE_PATH" || {
    echo "❌ Failed to archive logs."
    exit 1
}

# === Log Archive Event ===
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived $LOG_DIR to $ARCHIVE_PATH" >> "$LOG_FILE"

exit 0

