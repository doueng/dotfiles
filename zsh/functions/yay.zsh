# yay
yayuninstall() {
	yay -Rns "$1"
}

yaygitupdate() {
	yay -Syu --devel --timeupdate
}

yayprune() {
	yay -Yc
}
