#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
tightvncserver :1 -geometry 1280x1024 -depth 24
