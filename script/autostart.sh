dunst &
echo 3000 >"/tmp/current_temp.txt"
redshift -O 3000
xrandr --output VGA-0 --scale 1.2
xinput set-prop 12 'libinput Accel Speed' -0.55
feh --bg-fill ~/photos/bg.png
setxkbmap -layout us,ara -variant ,digits -option altwin:swap_alt_win -option grp:alt_caps_toggle caps:escape
slstatus &
sxhkd &
pulseaudio &
clipmenud &
/home/alinajib/script/statusTime.sh &
exec dwm
