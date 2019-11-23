dgcl() {
	gcl "git@github.com:doueng/$1.git"
}

new_priv_repo () {
	if [ "$#" -ne 1 ] ; then
		printf >&2 "Need one argument\n"
		return 2
	fi
	curl -H "Authorization: token `cat ~/.sec/github.sec`" --data "{\"name\":\"$1\", \"private\": true}" https://api.github.com/user/repos
	mk "$1"
	git init
	echo '*.o' > .gitignore
	git add .gitignore
	git commit -m "first commit"
	git remote add origin git@github.com:doueng/"$1".git
	git push -u origin master
}
