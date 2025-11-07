pacman -Qqen > pkglist.txt
pacman -Qqem > foreignpkglist.txt

pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
