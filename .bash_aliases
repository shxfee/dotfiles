alias so='source ~/.bashrc'
alias aa='vim ~/.bash_aliases'


alias cmp='composer'
alias gtvm='cd ~/repos/visitmv/app/'


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
