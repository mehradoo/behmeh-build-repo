#!/bin/bash
echo "Starting behmeh"

function sig()
{
  kill -TERM $PID
}
trap sig TERM INT

mkdir -p /var/lib/behmeh/apache_logs

# Run Apache in foreground so the container keeps running until stopped.
# But we background the process so we can handle SIGTERM properly
/usr/sbin/apache2ctl -D FOREGROUND &

PID=$!
wait $PID