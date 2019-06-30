
Debian
====================
This directory contains files used to package sikacoind/sikacoin-qt
for Debian-based Linux systems. If you compile sikacoind/sikacoin-qt yourself, there are some useful files here.

## sikacoin: URI support ##


sikacoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install sikacoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your sikacoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/sikacoin128.png` to `/usr/share/pixmaps`

sikacoin-qt.protocol (KDE)

