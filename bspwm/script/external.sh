#!/bin/sh


wid=$1
title=$(xtitle "$wid")

[ "$title" == "Android Emulator -"* ] && echo state=floating
