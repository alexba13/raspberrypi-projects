#!/bin/bash
OUT="/home/pi/monitoring/textfile-collector/folder_usage.prom"

du -s /home /var /usr /root | awk 'BEGIN {
  print "# HELP folder_size_kb Folder size in KB"
  print "# TYPE folder_size_kb gauge"
}
{
  print "folder_size_kb{path=\"" $2 "\"} " $1
}' > "$OUT"
