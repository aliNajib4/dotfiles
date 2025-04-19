if status is-interactive
    # Aliases for exa (modern ls replacement)
    alias ls='exa --color=auto'
    alias ll='exa --color=auto -la'
    alias l='exa --color=auto -l'
    alias la='exa --color=auto -a'
    alias lt='exa --color=auto -T'
    alias lt='exa --color=auto -aT'

    alias cd='__zoxide_z'
    alias cdi='__zoxide_zi'

    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx HOME /home/alinajib
    set -gx SHELL fish
    set -gx TERMINAL alacritty
    set -gx BROWSER firefox
    set -gx PRAYER_DATA_DIR /home/alinajib/preyData

    # Set XDG runtime directory
    set -gx XDG_RUNTIME_DIR /run/user/(id -u)

    # Add tmuxifier to PATH
    set -gx PATH $PATH ~/.config/tmux/plugins/tmuxifier/bin

    # xbps hotkeys
    alias i='doas xbps-install -S'
    alias u='i; and doas xbps-install -u xbps; and doas xbps-install -u'
    alias q='doas xbps-query -Rs'
    alias r='doas xbps-remove -R'
    alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

    alias vim='vim-x11'
    alias vi='nvim'
    alias nvi='nvim'

    alias cat='bat'
    alias fzf='fzf --preview="bat {}"'
    alias nzf='nvim $(fzf --preview="bat {}")'

    fish_vi_key_bindings
    eval (tmuxifier init - fish)
end

dunst &

# -- NNN --
export NNN_PLUG='n:nuke;j:autojump;o:fzopen;p:preview-tui;t:preview-tabbed;i:imgview;f:fzcd;d:dragdrop;m:nmount;x:xdgdefault;'

set -gx NNN_OPENER "/home/alinajib/.config/nnn/plugins/nuke" # Default opener for GUI files
set -gx NNN_COLORS 5236

# NNN dracula
set -gx NNN_FCOLORS 0404040000000600010F0F02

set --export NNN_FIFO "/tmp/nnn.fifo"

# powerup cd 
zoxide init fish | source

# Run script (if executable)
if test -x ~/script/next_prayer_time.sh
    ~/script/next_prayer_time.sh
end

doas loadkeys ~/.config/loadkeys/loadkeysrc

# Start X server if on TTY1 and no DISPLAY
if test -z "$DISPLAY" && test (tty) = /dev/tty1
    startx
end

# Add Go to PATH
set -gx PATH $PATH /usr/local/go/bin

# dracula
fish_config theme choose dracula

# exa dracula 
set -gx EXA_COLORS "\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
fi=37"

# dracula fzf
set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
