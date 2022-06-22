# make sure elogind is in USE flag
emerge x11-base/xorg-server

#need to install a terminal for startx
#if rust has not 11gb to compile, then get binary: emerge dev-lang/rust-bin
emerge x11-terms/alacritty

emerge neovim

# make sure X is in USE flag
emerge x11-wm/i3-gaps
emerge x11-misc/i3lock
# make use it is emerged with i3 support
USE="i3wm" emerge x11-misc/polybar

emerge dev-vcs/git 

#for equery command which asks for use flags of a package
emerge app-portage/gentoolkit

emerge www-client/firefox

emerge x11-misc/picom
#make sure to compile with jpeg USE flag
USE="jpeg" emerge x11-misc/nitrogen
emerge x11-misc/dmenu

#install siji fonts
# make sure to add corresponding lines to xinitrc
# use "fc-list | grep siji" to find out the name
# copy the name into polybar config
# it works if "fc-match NAME" does find the correct font file
# reload font cache: "fc-cache -fv"
git clone https://github.com/stark/siji && cd siji
./install.sh
cd
