#!/bin/sh

set -e

rm -f /app/src/tmp/pids/server.pid

bundle check || bundle install

exec bundle exec "$@"
