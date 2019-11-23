# restart shell
rz() {
	exec $SHELL
	source ~/.zprofile
}

le() {
   "$@" | less
}
