#!/bin/bash

set -e
#
# Watch for changes in /home/secondcrack/notes/draft folder and update nginx if there is one on /mnt/proxy
#
while inotifywait -r -e close_write,moved_to,create,modify,moved_from,moved_to "/home/secondcrack" *
do
	/home/secondcrack/engine/update.sh /home /home/secondcrack/
done

