#!/bin/bash
A1B2C3=$(date +%Y%m%d_%H%M%S)
D4E5F6="/home/administrator/Desktop/backup_$A1B2C3.sql"
echo "Начало..."
G7H8I9=$(psql -d postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('positgres', 'evendv');")
if [ -z "$G7H8I9" ]; then
    echo "нет данных."
    exit 1
fi
echo "список:"
for J0K1L2 in $G7H8I9; do
    echo "- $J0K1L2"
done
> "$D4E5F6"
function M3N4O5 { 
    local P6Q7R8=0.5 
    local S9T0U1="" 
    while true; do 
        echo -ne "\rВ процессе${S9T0U1}" 
        sleep $P6Q7R8 
        S9T0U1+="." 
        if [ ${#S9T0U1} -ge 3 ]; then 
            S9T0U1="" 
        fi 
    done 
}
M3N4O5 &
L2M3N4=$!
for J0K1L2 in $G7H8I9; do
    echo "копирование '$J0K1L2'..."
    if pg_dump -d "$J0K1L2" >> "$D4E5F6"; then
        echo "завершено '$J0K1L2'."
    else
        echo "ошибка '$J0K1L2'."
    fi
done
kill $L2M3N4
if [ $? -eq 0 ]; then
    echo -ne "\r"  
    echo "успех: $D4E5F6"
else
    echo -ne "\r"  
    echo "ошибка."
fi
echo "завершено."
echo "нажмите любую кнопку..."
read -n 1
