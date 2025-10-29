# interactive terminal check
[[ $- != *i* ]] && return

# variables
export GIT_USERNAME=$(git config --global user.name)

# history
export HISTSIZE=30
export HISTCONTROL=ignoredups:erasedups

shopt -s checkwinsize # re calculate window size if changed
shopt -s cdspell # file path auto correct for cd
shopt -s extglob # extended file querying

# cache local ip for prompt
LOCAL_IP=$(ip route get 1.1.1.1 | awk -F"src " 'NR==1{split($2,a," "); print a[1]}')

# if root else
if [[ $EUID -eq 0 ]]; then
  PS1='\[\033[01;31m\][\u@\h \W]\$\[\033[00m\] '
else
  PS1='\[\e[37m\][\[\e[90m\]$?\[\e[37m\]]\[\e[0m\] \[\e[90;1m\][\[\e[0;37m\]\T\[\e[90;1m\]]\[\e[0m\] \[\e[32;1m\]\u@'"${LOCAL_IP}"'\[\e[0m\] \[\e[32;1m\](\w)\$\[\e[0m\] '
fi

# toolchain specific
alias gc='git clone'

gitconf() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    return 1
  fi

  local PROTO="$1"
  local REPO="$2"

  local DISROOT
  local CODEBERG
  local GITHUB

  local USER="${GIT_USERNAME:-jerryjhird}"

  if [ "$PROTO" = "ssh" ]; then
    DISROOT="git@git.disroot.org:${USER}/${REPO}.git"
    CODEBERG="git@codeberg.org:${USER}/${REPO}.git"
    GITHUB="git@github.com:${USER}/${REPO}.git"
  elif [ "$PROTO" = "https" ]; then
    DISROOT="https://$USER@git.disroot.org/${USER}/${REPO}.git"
    CODEBERG="https://$USER@codeberg.org/${USER}/${REPO}.git"
    GITHUB="https://$USER@github.com/${USER}/${REPO}.git"
  else
    echo "protocol must be 'ssh' or 'https'"
    return 1
  fi

  git remote remove origin
  git remote add origin "$GITHUB"

  git remote set-url --add --push origin "$GITHUB"
  git remote set-url --add --push origin "$CODEBERG"
  git remote set-url --add --push origin "$DISROOT"

  git remote -v
}


# os aliases
alias _='sudo'
alias reload='source ~/.bashrc'
alias ls='ls --color=auto -a'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias ..='cd ..'

# alias python to python3 if python isnt a working command (python2 sets "python" as a command i think)
if command -v python3 >/dev/null 2>&1; then
  if ! command -v python >/dev/null 2>&1 && ! alias python >/dev/null 2>&1; then
    alias python='python3'
  fi
fi
