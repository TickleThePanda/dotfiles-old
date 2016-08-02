if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.prompt ]; then
  . ~/.prompt
fi

if [ -f ~/.env ]; then
  . ~/.env
fi
