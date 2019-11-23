updatedoom() {
	pgrep emacs | xargs kill -9;
	for cmd in upgrade update refresh;
		do ~/.emacs.d/bin/doom -y $cmd;
	done
	emacs --bg-daemon;
}

recompiledoom() {
	pkill emacs;
	~/.emacs.d/bin/doom -y recompile;
	emacs --bg-daemon;
}

# open files with emacs
e() {
	emacsclient -c -n "$@"
}

# evaluate as lisp expression
ee() {
	emacsclient -e "$@"
}
