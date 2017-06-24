#!/bin/bash

LOG_FILE_DIR="LOGS"
LOG_FILE_NOHUP="nohup.out"
LOG_FILE_ROCKSDB="hs_err_pid*.log"

function backup_logs ()
{
    # Move runtime logs to dedicated directory
    mkdir -p $LOG_FILE_DIR
    mv $LOG_FILE_ROCKSDB $LOG_FILE_DIR/
    cat $LOG_FILE_NOHUP >> $LOG_FILE_DIR/$LOG_FILE_NOHUP
    rm -f $LOG_FILE_NOHUP
}
