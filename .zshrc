# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

# export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----

eval "$(zoxide init --cmd cd zsh)"

# ---- Eza (better ls) -----

alias ls="eza --icons=always --color=always --long --git --no-filesize --no-time --no-user"
alias lsa="eza -a --icons=always --color=always --grid --git --no-filesize --no-time --no-user"
alias lst="eza -a --icons=always --color=always --tree --level=3 --git --no-filesize --no-time --no-user"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# ---- delete xcode devices ----
alias rmxcache="sudo ./.bin/removeXcodeCache.sh"

# obsidian
alias oo='cd $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/MartVault'
alias op='nvim $HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/MartVault'
alias or='nvim $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/MartVault/inbox/*.md'

# --------

alias gst="git status"
alias glo="git log --oneline"
alias h="~"
alias cl="clear"
alias n="nvim"
alias fl="fvm flutter"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/truongle/.dart-cli-completion/zsh-config.zsh ]] && . /Users/truongle/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# export env var for Yazi
export EDITOR="nvim"

# Shell wrapper for Yazi, use y instead of yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/.p10k.zsh.
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

export PATH=$HOME/Development/flutter/bin:$PATH
export PATH=$HOME/.gem/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"


export FLUTTER_PATH="$HOME/fvm/default/bin/flutter"
export DART_PATH="$HOME/fvm/default/bin/dart"

export PATH=~/.bin:$PATH
export PATH=~/.bin/on:$PATH
export PATH="/opt/homebrew/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
