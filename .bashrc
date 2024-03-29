case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\] on \[\033[01;35m\]\h ($(cat /proc/loadavg | awk "{print \$1\" \"\$2\" \"\$3}"))\[\033[01;34m\] in \[\033[01;34m\]\[\033[01;33m\]$PWD\[\033[00m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
fi
PS1=${PS1%?}\n'$ '
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -lFh'
alias la='ls -A'
alias l='ls -1'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export SDKMAN_DIR="/home/artem/.sdkman"
[[ -s "/home/artem/.sdkman/bin/sdkman-init.sh" ]] && source "/home/artem/.sdkman/bin/sdkman-init.sh"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
