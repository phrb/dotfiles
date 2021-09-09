#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Uncomment to get vsync options:
# picom --config ~/.config/picom.conf &
setxkbmap -layout us -variant intl &
xrdb -merge ~/.Xresources &
xbindkeys &
xset -b &
xset s 3600 3600 &
xset -dpms &
nm-applet &
cbatticon &
volumeicon &
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
