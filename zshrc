# --- History & Basic Setup ---
HISTFILE="$HOME/.cache/zsh/histfile"
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify appendhistory
unsetopt beep
bindkey -v

# --- Default Editor ---
export EDITOR='vim'

# --- Completions ---

zstyle :compinstall filename "$HOME/.zshrc"

# Generate LS_COLORS using vivid (using the catppuccin-mocha theme)
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Load colors and set up autocomplete menu colors using the generated LS_COLORS
autoload -U colors && colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"
# --- Tools ---
eval "$(starship init zsh)"
eval $(thefuck --alias)

# --- Aliases ---
alias ls='eza --icons --color=always'
alias ll='eza -lah --icons --color=always --git'
alias la='eza -a --icons --color=always'
alias tree='eza --tree --icons --color=always'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias vi='vim'

export BAT_PAGER="less -R --mouse"
alias cat='bat --style=plain --pager=never'
alias less='bat --paging=always'


# --- Plugins ---
ZSHRC_PATH="$HOME/.zshrc"
DOTFILES_DIR="${ZSHRC_PATH:A:h}"

source "$DOTFILES_DIR/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$DOTFILES_DIR/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
