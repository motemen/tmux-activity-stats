#!/bin/sh

LOGDIR=~/.tmux-activity-stats

mkdir -p $LOGDIR

while :; do
    echo time:$(date +%s)"\t"$(tmux list-panes -F "cmd:#{pane_current_command}\tcwd:#{pane_current_path}\ttitle:#{window_name}" | head -1) >> $LOGDIR/$(date +%F)
    sleep ${INTERVAL-10}
done
