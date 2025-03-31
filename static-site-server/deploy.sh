#!/bin/bash

LOCAL_DIR="./static-site/"
REMOTE_USER="ubuntu"
REMOTE_HOST="ec2-54-243-17-93.compute-1.amazonaws.com"
REMOTE_PATH="/var/www/static-site"

rsync -avz --delete "$LOCAL_DIR" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"
