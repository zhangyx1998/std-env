# Source profile and exit (if not sourced)
if [ -z "$PROFILE_SOURCED" ]; then
    export PROFILE_SOURCED=1
    source $HOME/.profile
    return
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.history
HISTSIZE=9999
bindkey -v
alias vi vim
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Begin user custom content

# Custom prompt style
STY="%{$(printf "\033[0;1;3;32m")%}"
PR1="${STY}%n"  # Green user name
STY="%{$(printf "\033[0;3;32m")%}"
PR2="${STY}@%M" # Dimmed Hostname
STY="%{$(printf "\033[0;34m")%}"
PR3="${STY}%4~" # Blue working directory
STY="%{$(printf "\033[0m")%}"
TRM="${STY} $ "  # Normal dollar sign
setopt PROMPT_SUBST
PROMPT="$PR1$PR2 $PR3$TRM"

# SSH Auto Complete
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
#if [[ -r ~/.ssh/known_hosts ]]; then
#  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
#fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# Gem installation location
export GEM_HOME="$HOME/.gems"
export PATH="$GEM_HOME/bin:$PATH"

# Homebrew environment setup
eval $(/opt/homebrew/bin/brew shellenv)
# End user custom content

export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3
