IMG="/tmp/image.png"

xclip -selection clipboard -o >"$IMG"

sxiv "$IMG"
