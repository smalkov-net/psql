#!/bin/bash
t=$(date +%Y%m%d_%H%M%S)
o="/home/monitoring/Desktop/backup_$t.sql"
echo "начало..."
f() { p=$1; d=0.1; s='/-\|'; while kill -0 $p 2>/dev/null; do for i in $(seq 0 3); do echo -ne "\r${s:$i:1} в процессе..."; sleep $d; done; done; echo -ne "\r"; }
pg_dumpall > "$o" & f $!
if [ $? -eq 0 ]; then echo "завершено успешно: backup_$t"; else echo "ошибка при копировании"; fi
echo "нажмите на любую кнопку..."
read -n 1
