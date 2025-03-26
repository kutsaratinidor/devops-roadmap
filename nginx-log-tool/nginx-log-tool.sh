#!/bin/bash

# === Usage Check ===
if [ -z "$1" ]; then
    echo "Usage: $0 <nginx_access_log_file>"
    exit 1
fi

LOGFILE="$1"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file '$LOGFILE' not found."
    exit 1
fi

echo "Analyzing log: $LOGFILE"
echo

# awk {print <target field>}
# sort     | Sorts the list (needed so that uniq can group them properly).
# uniq -c  | Counts how many times each unique IP appears.
# sort -nr | Sorts the counted lines numerically (-n) and in reverse (-r) so that highest counts appear first.
# head -5  | Shows only the top 5 results.
# awk -F\" | Sets the field separator to the double quote ("), which is how fields like request method and user-agent are wrapped in Nginx logs.

# === Top 5 IP addresses ===
echo "Top 5 IP addresses:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# === Top 5 requested paths ===
echo "Top 5 requested paths:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# === Top 5 response status codes ===
echo "Top 5 response status codes:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

# === Top 5 user agents ===
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

