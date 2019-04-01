#!/bin/sh
set -e

printenv | sed 's/^\(.*\)$/export \1/g' > /opt/docker_env.sh && chmod +x /opt/docker_env.sh

echo 'Starting cron'
crond -f