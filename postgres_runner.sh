#!/bin/bash

POSTGRES_BIN="postgres"

RAM_SIZE=`awk '/MemTotal/{print $2}' /proc/meminfo`
SHARED_BUFFERS="$(( RAM_SIZE / 1024 / 4 )) MB"
EFFECTIVE_CACHE_SIZE="$(( RAM_SIZE / 1024 / 2)) MB"
WORK_MEM="32 MB"
MAINTENANCE_WORK_MEM="320 MB"

echo "RAM SIZE: ${RAM_SIZE} kb"
echo "shared_buffers: ${SHARED_BUFFERS}"
echo "effective_cache_size: ${EFFECTIVE_CACHE_SIZE}"
echo "work_mem: ${WORK_MEM}"
echo "maintenance_work_mem: ${MAINTENANCE_WORK_MEM}"

exec  docker-entrypoint.sh -c shared_buffers="${SHARED_BUFFERS}" \
        -c effective_cache_size="${EFFECTIVE_CACHE_SIZE}" \
        -c work_mem="${WORK_MEM}" \
        -c maintenance_work_mem="${MAINTENANCE_WORK_MEM}"
