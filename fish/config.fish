alias so='source ~/.config/fish/config.fish'
alias se='nvim ~/.config/fish/config.fish'

alias cdw='cd /mnt/c/www/'
alias pu='./vendor/bin/phpunit'

alias art='php artisan '

alias gpu='git push'
alias gpl='git pull'
alias gs='git status'
alias gf='git fetch'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'
alias gtags='ctags -R --exclude=node_modules --exclude=.git --exclude=tests'

# update path
set PATH /home/shxfee/.composer/vendor/bin $PATH

# Start the Mysql Server and Apache Serve
# Run also bunch stuff here in the future for starting off the Development Env
function serve --description 'Bootstrap the dev environment'
    sudo service php7.3-fpm start; and sudo service nginx start; and sudo service mysql start
end

set -x STARSHIP_CONFIG ~/.config/fish/starship.toml
starship init fish | source
