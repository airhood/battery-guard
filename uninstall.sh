#!/usr/bin/env bash
set -euo pipefail

systemctl --user disable --now low-battery-guard.timer
systemctl --user stop low-battery-guard.service

rm -f -- "$HOME/.local/bin/battery-guard"
rm -f -- "$HOME/.config/systemd/user/low-battery-guard.service" "$HOME/.config/systemd/user/low-battery-guard.timer"
rm -f -- "$HOME/.local/libexec/battery-guard/low-battery-guard" "$HOME/.local/libexec/battery-guard/low-battery-prompt"
rmdir -- "$HOME/.local/libexec/battery-guard" 2>/dev/null || true
rm -f -- "${XDG_STATE_HOME:-$HOME/.local/state}/battery-guard/handled"
rmdir -- "${XDG_STATE_HOME:-$HOME/.local/state}/battery-guard" 2>/dev/null || true

systemctl --user daemon-reload
printf 'battery-guard를 제거했습니다.\n'
