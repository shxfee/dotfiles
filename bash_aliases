alias vi='nvim'
alias so='source ~/.bashrc'
alias se='nvim ~/.bash_aliases'
alias ..='cd ..'
alias ...='cd ../..'
alias tree='tree -L 2 --dirsfirst -a'

alias tmux='TERM=xterm-256color /usr/bin/tmux'
alias ktmux='tmux kill-server'

alias mysqll='mysql -u root -pn0password! test_blog'
alias sqlmap='python ~/.bin/sqlmap/sqlmap.py'

alias gpu='git push'
alias gpl='git pull'
alias gs='git status'
alias gf='git fetch'
alias ga='git add'
alias gc='git commit'

alias python=python3

de(){
    tmux new-session -d
    tmux new-window 'vim -O2'
    #   tmux new-window 'mysql -u root -pn0password!'
    tmux select-window -t :2
    tmux -2 attach-session -d
}
