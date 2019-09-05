#!/bin/sh

# This file is part of Synoindex Watcher.
#
# Copyright (c) 2012-2018 Mark Houghton <https://codesourcery.wordpress.com>
# Copyright (c) 2019 Torben Haase <https://pixelsvsbytes.com>
#
# Synoindex Watcher is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# Synoindex Watcher is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.You should have received a copy of the GNU General Public License
# along with Synoindex Watcher.  If not, see <http:#www.gnu.org/licenses/>.
#
################################################################################

case "$1" in
  start|"")
    mkdir -p /var/run/synoindexwatcher
    # Set LC_ALL to ensure that the filesystem encoding is correctly detected
    # during boot.
    nohup env LC_ALL=en_US.utf8 python -m synoindexwatcher \
      --logfile /var/log/synoindexwatcher.log \
      --loglevel INFO > /dev/null 2>&1 &
    echo $! > /var/run/synoindexwatcher/init.pid
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    kill `cat /var/run/synoindexwatcher/init.pid`
    ;;
  *)
    echo "Usage: synoindexwatcher.sh [start|stop]" >&2
    exit 3
    ;;
esac
