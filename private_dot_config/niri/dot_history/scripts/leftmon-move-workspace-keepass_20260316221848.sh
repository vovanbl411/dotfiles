#!/usr/bin/env bash

APP_ID="org.keepassxc.KeePassXC"
TARGET_WORKSPACE=2   # можно указать имя, например "left", если хотите

# Запускаем KeePassXC в фоне
flatpak run "$APP_ID" &

# Функция получения ID окна по app_id (аналогично вашему скрипту)
get_id() {
    niri msg --json windows | jq -r ".[] | select(.app_id == \"$1\") | .id"
}

# Ждём появления окна (до 10 секунд)
for i in {1..50}; do
    WIN_ID=$(get_id "$APP_ID")
    if [ -n "$WIN_ID" ]; then
        break
    fi
    sleep 0.2
done

if [ -z "$WIN_ID" ]; then
    exit 1
fi

# Фокусируем окно по ID
niri msg action focus-window --id "$WIN_ID"

# Перемещаем колонку с окном на нужный workspace
niri msg action move-window-to-workspace "$TARGET_WORKSPACE"

echo "KeePassXC перемещён на workspace $TARGET_WORKSPACE"