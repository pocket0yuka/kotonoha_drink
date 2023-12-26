#!/bin/bash

set -e

rm -f /kotonoha_drink/tmp/pids/server.pid

exec "$@"