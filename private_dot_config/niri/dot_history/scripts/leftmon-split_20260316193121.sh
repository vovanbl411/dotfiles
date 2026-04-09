#!/usr/bin/env bash

sleep 10

# Запускаем btop (он будет базовым окном в колонке)
kitty --class btop-sys -e btop &

sleep 1

# Запускаем nvtop
kitty --class nvtop-sys -e nvtop &

# Находим ID окна nvtop-sys динамически
# Мы берем список окон в JSON, ищем там app_id == "nvtop-sys" и забираем его числовой .id
NVTOP_ID=$(niri msg --json windows | jq '.[] | select(.app_id == "nvtop-sys") | .id')

# 4. Если ID найден, фокусируемся на нем и объединяем влево
if [ -n "$NVTOP_ID" ]; then
    niri msg action focus-window --id "$NVTOP_ID"
    niri msg action consume-or-expel-window-left
fi