source $HOME/.zsh/variables.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/flags.zsh

# Theme
if { [ "$OS" = "macos" ]; }
  then
    ZSH_THEME="refined"
    fpath=( "$ZSH/custom/plugins/pure" $fpath )
  else
    ZSH_THEME="robbyrussell"
fi


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Plugins
# ~/.oh-my-zsh/plugins/
# ~/.oh-my-zsh/custom/plugins/
plugins=(zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if ! { [ -n "$TMUX" ]; } then
  builtin cd $rc && git pull -q && builtin cd - &&
  if { [ "$TERM_PROGRAM" = "iTerm.app" ]; }
    then
      tmux attach -t iTerm || tmux new -s iTerm
    else
      tmux attach -t init || tmux new -s init
  fi
fi
