#!/bin/bash
T1M3ST4MP=$(date +%Y%m%d_%H%M%S)
O_U_T_P_U_T_F1LE="/home/administrator/Desktop/backup_$T1M3ST4MP.sql"
echo "Начало ..."
d4t4b4s3s=$(psql -d postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('pustgres', 'evendv');")
if [ -z "$d4t4b4s3s" ]; then
    echo "нет доступных данных."
    exit 1
fi
echo "список данных:"
for dB in $d4t4b4s3s; do
    echo "- $dB"
done
> "$O_U_T_P_U_T_F1LE"
function l0ad1ng_fnc { 
    local d3l4y=0.5 
    local d0t5="" 
    while true; do 
        echo -ne "\rв процессе${d0t5}" 
        sleep $d3l4y 
        d0t5+="." 
        if [ ${#d0t5} -ge 3 ]; then 
            d0t5="" 
        fi 
    done 
}
l0ad1ng_fnc &
l0ad1ng_pid=$!
for dB in $d4t4b4s3s; do
    echo "данные '$dB'..."
    if pg_dump -d "$dB" >> "$O_U_T_P_U_T_F1LE"; then
        echo "данные '$dB' завершено."
    else
        echo "ошибка при копировании '$dB'."
    fi
done
kill $l0ad1ng_pid
if [ $? -eq 0 ]; then
    echo -ne "\r" 
    echo "завершено успешно: $O_U_T_P_U_T_F1LE"
else
    echo -ne "\r"
    echo "завершено с ошибкой."
fi
echo "завершен."
echo "Нажмите на любую кнопку..."
read -n 1
