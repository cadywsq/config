stty -ixon -ixoff
# =============================================================================
# history
# =============================================================================
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# =============================================================================
# completiton
# =============================================================================
fpath=("${0:h}/zsh-completions" $fpath)
autoload -Uz compinit && compinit -i
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
# hide uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
  avahi daemon git mail nobody uuidd bin dbus http mpd ntp postgres xbmc colord ftp mysql polkitd 'systemd-*'

# =============================================================================
# zplug
# =============================================================================
source ~/.zplug/init.zsh

zplug "Tarrasch/zsh-bd"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2, use:zsh-syntax-highlighting.zsh
zplug "zsh-users/zsh-autosuggestions"
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/common-alias", from:oh-my-zsh
zplug "plugins/compleat", from:oh-my-zsh
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/dirpersist", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/git-extra", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/urltools", from:oh-my-zsh
zplug "plugins/per-directory-history", from:oh-my-zsh
zplug "~/.zsh/fzy_support.zsh", from:local

zplug "themes/agnoster", from:oh-my-zsh, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# My stuff
pathto(){
    echo -n $PWD/$1 | xclip -selection clipboard
}

cdt() {
    cd $1 2> /dev/null || cd $(dirname $1)
}

function sj() {
    if [[ $PWD =~ '(.*)/javatests(.*)' ]]; then
        cd "${match[1]}/java${match[2]}"
    else
        cd "${PWD/\/google3\/java//google3/javatests}"
    fi
}

function bb() {
  if [[ $PWD =~ '(.*)/blaze-bin(.*)' ]]; then
    cd "${match[1]}${match[2]}"
  else
    cd "${PWD/\/google3//google3/blaze-bin}"
  fi
}
