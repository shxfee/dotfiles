alias so='source ~/.bashrc'
alias se='vim ~/.bash_aliases'
alias ..='cd ..'
alias ...='cd ../..'

alias vim='vim -O2'

alias cake='./Console/cake'
alias cbc='cake bake controller'
alias cbm='cake bake model'
alias cbv='cake bake view'

alias tmux='TERM=xterm-256color /usr/bin/tmux'
alias ktmux='tmux kill-server'

alias mysqll='mysql -u root -pn0password! test_blog'
alias sqlmap='python ~/.bin/sqlmap/sqlmap.py'

alias gpu='git push -u origin master'
alias gpl='git pull'
alias gs='git status'
alias gf='git fetch'
alias ga='git add --all :/'
alias gc='git commit'

bake() {
    case "$1" in
        cake)
            echo "Baking a Cakephp 2.5 Project..";
            echo "Unzipping & Inflating cake archive...";
            unzip ~/repos/.libs/cakephp-2.5.4.zip > /dev/null;

            echo "Setting app/tmp permissions to 777...";
            chmod -R 777 ./app/tmp;


            echo "Updating Cake.Core security salt...";
            rep=$(date | md5sum | cut -c1-18);
            sed -i "s/DYhG93b0qyJfIxfs2g/$rep/" ./app/Config/core.php;

            echo "Updating Cake.Core security cypher...";
            rep="$(($RANDOM * 9987))574535888";
            sed -i "s/768593096574535424/$rep/" ./app/Config/core.php;

            echo "Finished baking new Cake project...";
            ;;


        foundation)
            echo "Baking Foundation 5 support..";
            echo "Unzipping & Inflating archive...";
            unzip ~/repos/.libs/foundation-5.4.0.zip > /dev/null;
            echo "Finished baking Foundation 5 support.";
            ;;

        *)
        echo $"Usage: bake [cake|foundation]"

    esac
}


de(){
    tmux new-session -d
    tmux new-window 'vim -O2'
#   tmux new-window 'mysql -u root -pn0password!'
    tmux select-window -t :2
    tmux -2 attach-session -d
}


emysql(){
   value=$(cat)
   echo "$value" | mysql -u root -pn0password! test_blog -t
}
