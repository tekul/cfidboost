#! /bin/sh

# Create tmux session called 'cfid'
tmux new-session -d -s cfid 'sh ./start-nginx.sh'

# Create separate windows for tomcat and postgres
tmux new-window -t cfid:1 -n 'tomcat' 'sh ./start-tomcat.sh'
tmux new-window -t cfid:2 -n 'postgres' 'sh ./start-postgres.sh'

tmux select-window -t 0
# Create pane for nginx log
tmux split-window -t 0 -h -p 60 'sleep 30 && tail -f logs/nginx/access.log'
# Re-select the nginx pane in case system password is needed
tmux select-pane -t 0

tmux -2 attach-session -t cfid


