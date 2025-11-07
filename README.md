```
# "Backup"
pacman -Qqen > pkglist.txt
pacman -Qqem > foreignpkglist.txt
# "Restore"
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort pkglist.txt))
```
