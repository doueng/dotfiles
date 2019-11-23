hex() {
	printf "%x\n" $1
}

int() {
	printf "%d\n" $1
}

# needs zsh
bin() {
	echo $(([##2] $1 ))
}
