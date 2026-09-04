#!/usr/bin/env bash
# Restore last saved tmux sessions once per fresh server boot.
# Called from ~/.tmux.conf (before plugin load) so sessions appear instantly.

RESURRECT_DIR="$HOME/.tmux/resurrect"
RESURRECT_RESTORE="$HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh"
DONE_OPTION="@auto-restore-done"
MAX_START_AGE="300"

[ -f "$HOME/tmux_no_auto_restore" ] && exit 0
[ -n "$(tmux show-option -gqv "$DONE_OPTION" 2>/dev/null)" ] && exit 0
# "last" must point to a non-empty, non-garbage archive; otherwise restoring
# would "restore nothing" and the boot-time auto-save would then archive that
# empty state over the last good one. If "last" is missing/broken, fall back to
# the newest valid archive on disk (backups can be cleaned up externally).
if [ ! -s "$RESURRECT_DIR/last" ] ||
  ! grep -qE '^(pane|window|state)' "$RESURRECT_DIR/last" 2>/dev/null; then
  newest="$(ls -t "$RESURRECT_DIR"/tmux_resurrect_*.txt 2>/dev/null | head -1)"
  if [ -z "$newest" ] ||
    ! grep -qE '^(pane|window|state)' "$newest" 2>/dev/null; then
    exit 0
  fi
  ln -sf "$(basename "$newest")" "$RESURRECT_DIR/last"
fi

start_time="$(tmux display-message -p '#{start_time}' 2>/dev/null)"
[ -n "$start_time" ] || exit 0
[ $(($(date +%s) - start_time)) -le "$MAX_START_AGE" ] || exit 0

tmux set-option -gq "$DONE_OPTION" "on"
"$RESURRECT_RESTORE" >/dev/null 2>&1
tmux set-option -gq "$DONE_OPTION" "done"

# kill the leftover default session created at config load (restore just added
# the real ones)
if tmux has-session -t "0" 2>/dev/null; then
  non_default_sessions="$(tmux list-sessions -F '#{session_name}' 2>/dev/null | grep -v '^0$' | wc -l | tr -d ' ')"
  panes_in_zero="$(tmux list-panes -t "0" 2>/dev/null | wc -l | tr -d ' ')"
  if [ "$non_default_sessions" -gt 0 ] && [ "$panes_in_zero" -eq 1 ]; then
    tmux kill-session -t "0" 2>/dev/null
  fi
fi

exit 0
