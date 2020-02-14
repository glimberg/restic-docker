#!/bin/bash
set -e
# credit: some of the code for this script inspired by https://github.com/lobaro/restic-backup-docker

logFile="/var/log/restic/backup/$(date +"%Y-%m-%d-%H-%M-%S").log"

log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")]$1" | tee -a "$logFile"
}

flock -xn /root/restic.lock /root/do_backup.sh
rc=$?
if [[ $rc != 0 ]]; then
	log "[INFO] Backup already running. Exiting"
fi

