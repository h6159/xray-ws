#!/bin/sh
set -e
PORT="${PORT:-8080}"
UUID="${UUID:?UUID env var is required}"
sed -e "s/__PORT__/${PORT}/g" -e "s/__UUID__/${UUID}/g" \
  /usr/local/etc/xray/config.template.json > /tmp/config.json
exec /usr/local/bin/xray run -config /tmp/config.json
