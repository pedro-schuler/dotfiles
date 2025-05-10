# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

export PATH="$HOME/.config/juliaup/bin:$HOME/.local/texlive/2025/bin/x86_64-linux:$HOME/.local/bin/:$HOME/.config/emacs/bin:$PATH"
export EDITOR="nvim"
# Add Carapace bridges to provide completions
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional

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
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

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
autoload -Uz compinit && compinit

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source <(carapace _carapace)

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward bindkey '^n' history-search-forward bindkey '^[w' kill-region # History
HISTSIZE=5000
HISTFILE=~/.histfile
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Aliases
alias vim='nvim'
alias top='btop'
alias cat='bat'
alias c='clear'
alias emc="emacsclient -c -a 'emacs'"
alias ls="ls -lah --color --group-directories-first"
alias la="eza -lah --color-scale=all --group-directories-first --icons=always"
alias ld="eza -lDh --color-scale=all --icons=always"
alias ld.="eza -lDah --color-scale=all --icons=always"
alias lf="eza -lfh --color-scale=all --icons=always"
alias lf.="eza -lfah --color-scale=all --icons=always"
alias lh="eza -ldh .* --color-scale=all --icons=always"
alias mutt-pessoal="neomutt -F ~/.config/mutt/muttrc-pessoal"
alias mutt-trabalho="neomutt -F ~/.config/mutt/muttrc-trabalho"
alias mutt-faculdade="neomutt -F ~/.config/mutt/muttrc-faculdade"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"

# Start tmux
#if ! systemctl --user is-active --quiet tmux.service; then
#    systemctl --user start tmux.service
#fi
#eval "$(tmux attach-session -d >/dev/null 2>&1)"
