alias vi='nvim'
alias so='source ~/.config/fish/config.fish'
alias se='nvim ~/.config/fish/config.fish'

alias cdw='cd /mnt/c/www/'
alias pu='./vendor/bin/phpunit'

alias art='php artisan '

alias mysqll='mysql -u root -pn0password! test_blog'
alias sqlmap='python ~/.bin/sqlmap/sqlmap.py'

alias gpu='git push'
alias gpl='git pull'
alias gs='git status'
alias gf='git fetch'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'
alias python='python3'

function open
 set l (echo $argv | string trim -l -c './')
 echo $l
 explorer.exe $l
end

# Start the Mysql Server and Apache Serve
# Run also bunch stuff here in the future for starting off the Production Env
function serve --description 'Bootstrap the dev environment'
    sudo /etc/init.d/mysql restart
    sudo /etc/init.d/nginx restart
end
