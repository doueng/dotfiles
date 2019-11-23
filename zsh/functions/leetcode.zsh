# leetcode download
lcd() {
	lc show "$1" >> $(lc show "$1" -g -l python | ag "Source Code" | awk '{print $4}')
}
