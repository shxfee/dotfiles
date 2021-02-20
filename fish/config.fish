alias vi='~/source/squashfs-root/usr/bin/nvim'
alias vim='~/source/squashfs-root/usr/bin/nvim'
alias nvim='~/source/squashfs-root/usr/bin/nvim'
alias so='source ~/.config/fish/config.fish'
alias se='vi ~/.config/fish/config.fish'

alias cdw='cd /var/www/'
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

alias windown='sudo umount /mnt/c'
alias winup='sudo mount -t drvfs C: /mnt/c'

# update path
set PATH /home/shxfee/.composer/vendor/bin $PATH

# Open links with wslview
set BROWSER wslview

# Start the Mysql Server and Apache Serve
# Run also bunch stuff here in the future for starting off the Development Env
function serve --description 'Bootstrap the dev environment'
    sudo service php7.3-fpm start; and sudo service nginx start; and sudo service mysql start
end

set -x STARSHIP_CONFIG ~/.config/fish/starship.toml
starship init fish | source


# This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# up memory, this command will free your memory after about 20-30 seconds.
#   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
