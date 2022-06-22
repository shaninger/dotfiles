# make sure elogind is in USE flag
emerge x11-base/xorg-server

#need to install a terminal for startx
#if rust has not 11gb to compile, then get binary: emerge dev-lang/rust-bin
emerge x11-terms/alacritty

emerge neovim

# make sure X is in USE flag
emerge x11-wm/i3-gaps
emerge x11-misc/i3lock
emerge x11-misc/polybar

emerge dev-vcs/git 

#for equery command which asks for use flags of a package
emerge app-portage/gentoolkit

emerge www-client/firefox
