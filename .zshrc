HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt append_history
setopt inc_append_history

# -------------------
#       Aliases
# -------------------

# make some things nicer
alias ip='ip -c'
alias free='free -h'
alias diff='diff --color'
alias df='df -h'

alias ls='ls -h --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -A1'

alias ..="cd ../"
alias ...="cd ../../"
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias shutn="shutdown now"
alias pss="pacman -Ss"
alias pqq='pacman -Qq'


# -------------------
#      Functions
# -------------------

function clone {
    [[ $1 != "" ]] && git clone git@github.com:$1
}

# ------------------
#       Prompt
# ------------------

# git_status() {
#   git_status="$(git status 2> /dev/null)"
#   [[ "$git_status" =~ "Changes to be committed:" ]] && echo -n "%F{green}·%f"
#   [[ "$git_status" =~ "Changes not staged for commit:" ]] && echo -n "%F{yellow}·%f"
#   [[ "$git_status" =~ "Untracked files:" ]] && echo -n "%F{red}·%f"
# }

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git
NEWLINE=$'\n'
PROMPT='%F{238}╔%F{default} %F{yellow}%n%F{default} %F{green}%(4~|%-1~/⋯/%3~|%4~)%F{default} %F{240}$vcs_info_msg_0_ $NEWLINE%F{238}╚%F{default}%F{238}═>%F{default} '


# ------------------
#      Env Vars     
# ------------------

export LD_LIBRARY_PATH="/usr/local/lib/"
export EDITOR='nvim'
export PATH="$HOME/scripts:$HOME/.local/bin:$HOME/programs/neovim-bin/bin:$PATH"

# for the most part nice colours for man pages
# https://unix.stackexchange.com/questions/119/colors-in-man-pages/329092#329092
# export MANPAGER='nvim --cmd ":lua vim.g.noplugins=1" +Man!'
export LESS="-Fr"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput bold)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
# for some reason this is needed no clue why
export GROFF_NO_SGR=1


# -------------------   
#   Initialisations  
# -------------------

if [[ -d ~/.zsh/plugins/fast-syntax-highlighting ]] then
    source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

# completion with colours
autoload -Uz compinit
compinit

# ocaml related
eval $(opam env)
pfetch
