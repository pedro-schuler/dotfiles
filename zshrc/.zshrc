# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

typeset -U path PATH
path=(
  "$HOME/.config/juliaup/bin"
  "$HOME/.local/texlive/2026/bin/x86_64-linux"
  "$HOME/.local/bin"
  "$HOME/.config/emacs/bin"
  $path
)

export PATH
export MANPATH="$HOME/.local/texlive/2026/texmf-dist/doc/man:$MANPATH"
export INFOPATH="$HOME/.local/texlive/2026/texmf-dist/doc/info:$INFOPATH"
export EDITOR="nvim"
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# Add Carapace bridges to provide completions
export CARAPACE_BRIDGES='zsh' # optional

#Iniciar oh my posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.toml)"
#
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
#zinit snippet OMZP::ssh-agent
#zinit snippet OMZP::aws
#zinit snippet OMZP::kubectl
#zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

if [[ ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  zcompile ~/.zcompdump
fi

#source /usr/share/fzf/completion.zsh
#source /usr/share/fzf/key-bindings.zsh
source <(carapace _carapace)

zinit cdreplay -q

# auto-suggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

# Keybindings
bindkey -e
bindkey '^p' history-search-backward # History
bindkey '^n' history-search-forward # History
bindkey '^[w' kill-region # History
HISTSIZE=100000
HISTFILE=~/.histfile
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_expire_dups_first
setopt hist_verify
setopt inc_append_history_time
unsetopt share_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extended_glob
setopt glob_dots
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':fzf-tab:complete:cd:*'  fzf-preview 'eza --icons=always --color=always "$realpath"'
zstyle ':fzf-tab:complete:__zoxide_z:*'  fzf-preview 'eza --icons=always --color=always "$realpath"'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' show-group quiet
zstyle ':completion:*:descriptions' format '[%d]'

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias vim='nvim'
alias top='btop'
alias cat='bat'
alias c='clear'
alias emc="emacsclient -c -a 'emacs'"
#alias ls="ls -lah --color --group-directories-first"
alias ls='eza -lah --group-directories-first --icons=auto'
alias la="eza -lah --color-scale=all --group-directories-first --icons=always"
alias ld="eza -lDh --color-scale=all --icons=always"
alias ld.="eza -lDah --color-scale=all --icons=always"
alias lf="eza -lfh --color-scale=all --icons=always"
alias lf.="eza -lfah --color-scale=all --icons=always"
alias lh="eza -ldh .* --color-scale=all --icons=always"
alias mutt-pessoal="neomutt -F ~/.config/mutt/muttrc-pessoal"
alias mutt-trabalho="neomutt -F ~/.config/mutt/muttrc-trabalho"
alias mutt-faculdade="neomutt -F ~/.config/mutt/muttrc-faculdade"

# add atuin for history
eval "$(atuin init zsh)"

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(pay-respects zsh --alias)"

# Start tmux
#if ! systemctl --user is-active --quiet tmux.service; then
#    systemctl --user start tmux.service
#fi
#eval "$(tmux attach-session -d >/dev/null 2>&1)"
