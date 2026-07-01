#!/bin/sh
set -eu

INSTALL_ROOT="${WGW_APP_ROOT:-/var/www/install}"
API_ROOT="/var/www/packages/api"

# Recreate writable directories in case they are backed by a mounted volume that was empty
# on first start. Operations are idempotent — existing directories and their contents are
# left untouched.
mkdir -p \
  "${INSTALL_ROOT}/wgw-content" \
  "${API_ROOT}/storage/framework/cache" \
  "${API_ROOT}/storage/framework/sessions" \
  "${API_ROOT}/storage/framework/views" \
  "${API_ROOT}/storage/logs" \
  "${API_ROOT}/bootstrap/cache"
chown -R www-data:www-data \
  "${INSTALL_ROOT}/wgw-content" \
  "${API_ROOT}/storage" \
  "${API_ROOT}/bootstrap/cache" 2>/dev/null || true

exec docker-php-entrypoint "$@"
