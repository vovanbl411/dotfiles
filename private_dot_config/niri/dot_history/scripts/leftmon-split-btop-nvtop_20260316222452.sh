#!/usr/bin/env bash

# 1. Запускаем утилиты
kitty --class btop-sys -e btop &
kitty --class nvtop-sys -e nvtop &

# 2. Функция для получения ID по app_id
get_id() {
    niri msg --json windows | jq -r ".[] | select(.app_id == \"$1\") | .id"
}

# 3. Ждем появления обоих окон (максимум 10 секунд)
for i in {1..50}; do
    BTOP_ID=$(get_id "btop-sys")
    NVTOP_ID=$(get_id "nvtop-sys")
    
    if [ -n "$BTOP_ID" ] && [ -n "$NVTOP_ID" ]; then
        break
    fi
    sleep 0.2
done

# Если окна не нашлись — выходим (теперь фикс тут)
if [ -z "$NVTOP_ID" ]; then 
    exit 1
fi

#  Выполняем связку по ID
niri msg action focus-window --id "$NVTOP_ID"
niri msg action consume-or-expel-window-left
