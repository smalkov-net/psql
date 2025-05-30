#!/bin/bash
t=$(date +%Y%m%d_%H%M%S); o="/home/monitoring/Desktop/backup_$t.sql"; echo "начало..."; pg_dumpall > $o; if [ $? -eq 0 ]; then echo "завершено успешно: backup_$t"; else echo "ошибка при копировании"; fi; echo "нажмите на любую кнопку..."; read -n 1
