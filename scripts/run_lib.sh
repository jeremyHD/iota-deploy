#!/bin/bash

LOG_FILE_DIR="LOGS"
LOG_FILE_NOHUP="nohup.out"
LOG_FILE_ROCKSDB="hs_err_pid*.log"
LOG_FILE_IRI_PID="/var/run/iri.pid"

function backup_logs()
{
    # Move runtime logs to dedicated directory
    mkdir -p $LOG_FILE_DIR
    mv $LOG_FILE_ROCKSDB $LOG_FILE_DIR/

    # TODO: Compression when the file size up to a specific size.
    cat $LOG_FILE_NOHUP >> $LOG_FILE_DIR/$LOG_FILE_NOHUP

    # Backup PID file
    cp $LOG_FILE_IRI_PID $LOG_FILE_DIR/

    # Remove old nohup log file
    rm -f $LOG_FILE_NOHUP
}
