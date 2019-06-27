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
    sudo service mysql start
    sudo service nginx start
    sudo service php7.2-fpm start
end


# update path
set PATH /home/shxfee/.composer/vendor/bin $PATH
set -Ux LS_COLORS "di=34:ln=35:so=32:pi=33:ex=34:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;47"
