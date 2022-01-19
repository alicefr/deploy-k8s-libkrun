#!/bin/bash
set -x
mount -o remount,ro /sys
mount -o remount,ro /proc/sys
mount --make-rshared /

exec /sbin/init
