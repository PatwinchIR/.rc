
source $HOME/.zsh/variables.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/flags.zsh

# Theme
if { [ "$OS" = "macos" ]; }
  then
    ZSH_THEME="d_d"
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

compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# if ! { [ -n "$TMUX" ]; } then
#   builtin cd $rc && git pull -q && builtin cd - &&
#   if { [ "$TERM_PROGRAM" = "iTerm.app" ]; }
#     then
#       tmux attach -t iTerm || tmux new -s iTerm
#     else
#       tmux attach -t init || tmux new -s init
#   fi
# fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/d_d/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/d_d/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/d_d/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/d_d/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
