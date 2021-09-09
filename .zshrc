EDITOR=/usr/bin/vim
VISUAL=/usr/bin/vim
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000

setopt nomatch
setopt interactivecomments
unsetopt beep
bindkey -v

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            VIM_PROMPT="N"
            ;;
        main|viins)
            VIM_PROMPT="I"
            ;;
        *)
            VIM_PROMPT="I"
            ;;
    esac
    PROMPT="$VIM_PROMPT%% "
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# End of lines configured by zsh-newuser-install

precmd () {print -Pn "\e]0;%~\a"}

alias exa="exa -rbghlum"
alias ls="exa --sort=modified"
alias ll="ls -a"
alias l="ls"
alias cll="clear && ll"
alias cl="clear && l"

#alias ls="ls --color=auto -lht"
#alias ll="ls -A"
#alias l="ls"
#alias cll="clear && ll"
#alias cl="clear && l"

alias grep="grep --color=auto"
alias less="less -NSMJ"
#alias mpv="prime-run mpv --sid=no --volume=60 --audio-channels=stereo"
alias mpv="mpv --sid=no --volume=60 --audio-channels=stereo"
alias mplayer="mplayer -nosub -volume 40 -channels 2"
alias fcpu="watch grep \'cpu MHz\' /proc/cpuinfo"
alias fsensors="watch sensors"
#alias impressive="impressive --noquit --tracking -t Crossfade -T 230 --fullscreen -g 1920x1080"
alias impressive="impressive --noquit --tracking -t Crossfade -T 230 --windowed -g 1920x1080 --noclicks --nologo --cache persistent"

# export WINEDEBUG=-all
#alias steam-wine='optirun -b primus wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-cef-sandbox'
#alias steam="LD_PRELOAD='/usr/\$LIB/libstdc++.so.6 /usr/\$LIB/libgcc_s.so.1 /usr/\$LIB/libxcb.so.1 /usr/\$LIB/libgpg-error.so' /usr/bin/steam-native"

#alias steam="optirun -b primus steam"

## Base16 Shell
#BASE16_SCHEME="default"
#BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
#[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# The following lines were added by compinstall
zstyle :compinstall filename '/home/phrb/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall
promptinit
prompt off

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#     function zle-line-init () {
#         printf '%s' "${terminfo[smkx]}"
#     }
#     function zle-line-finish () {
#         printf '%s' "${terminfo[rmkx]}"
#     }
#     zle -N zle-line-init
#     zle -N zle-line-finish
# fi

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# For Ruby Gems
export GEM_HOME=$HOME/gems

export PATH=$HOME/gems/bin:$HOME/bin:$PATH
