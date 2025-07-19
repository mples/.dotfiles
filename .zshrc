export PATH="$PATH:/snap/bin"
export PATH="$PATH:/home/mateusz/.local/bin"
unsetopt LIST_BEEP


alias l="ls -hal"

#Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Syntax syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Syntax auto suggestions
zinit light zsh-users/zsh-autosuggestions

# zsh completions
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
bindkey '^f' autosuggest-accept
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # color ls completion

# History Config
HISTSIZE=5000
HISTFIZE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ls='ls --color'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# improve completion with fzf
zinit light Aloxaf/fzf-tab
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'ls --color $realpath'

# Plugins from OMZP
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found

zinit cdreplay -q

# zoxide
eval "$(zoxide init --cmd cd zsh)"
zstyle ":fzf-tab:complete:__zoxide_z:*" fzf-preview "ls --color $realpath"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"



