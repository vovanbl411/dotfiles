#!/usr/bin/env bash

# 1. Запускаем btop в фоне
kitty --class btop-sys -e btop &

# 2. Ждем, пока niri зарегистрирует окно btop-sys (проверяем каждые 0.1 сек)
while ! niri msg windows | grep -q "btop-sys"; do
    sleep 0.1
done

# 3. Запускаем nvtop в фоне
kitty --class nvtop-sys -e nvtop &

# 4. Ждем, пока niri зарегистрирует окно nvtop-sys
while ! niri msg windows | grep -q "nvtop-sys"; do
    sleep 0.1
done

# 5. Как только оба окна существуют, фокусируемся на nvtop и поглощаем его влево
niri msg action focus-window --app-id nvtop-sys
niri msg action consume-or-expel-window-left