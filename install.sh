#!/usr/bin/env bash
set -euo pipefail

source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

for command_name in bash systemctl gnome-terminal install; do
    if ! command -v "$command_name" >/dev/null; then
        printf '필요한 명령을 찾을 수 없습니다: %s\n' "$command_name" >&2
        exit 1
    fi
done

if ! systemctl --user show-environment >/dev/null 2>&1; then
    printf '사용자 systemd 세션에서 실행해야 합니다.\n' >&2
    exit 1
fi

install -d "$HOME/.local/bin" "$HOME/.local/libexec/battery-guard" "$HOME/.config/systemd/user"
install -m 755 "$source_dir/bin/battery-guard" "$HOME/.local/bin/battery-guard"
install -m 755 "$source_dir/libexec/low-battery-guard" "$HOME/.local/libexec/battery-guard/low-battery-guard"
install -m 755 "$source_dir/libexec/low-battery-prompt" "$HOME/.local/libexec/battery-guard/low-battery-prompt"
install -m 644 "$source_dir/systemd/low-battery-guard.service" "$HOME/.config/systemd/user/low-battery-guard.service"
install -m 644 "$source_dir/systemd/low-battery-guard.timer" "$HOME/.config/systemd/user/low-battery-guard.timer"

systemctl --user daemon-reload
systemctl --user enable --now low-battery-guard.timer
printf '설치했습니다. battery-guard start|stop|status로 제어하세요.\n'
