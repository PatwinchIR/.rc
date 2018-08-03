cd $HOME

mkdir .macos

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s $HOME/.rc/zshrc $HOME/.zshrc

mkdir .zsh

ln -s $HOME/.rc/zshalias $HOME/.zsh/alias.zsh
ln -s $HOME/.rc/zshflags f$HOME/.zsh/lags.zsh
ln -s $HOME/.rc/zshfunctions $HOME/.zsh/functions.zsh
ln -s $HOME/.rc/zshvar $HOME/.zsh/variables.zsh

ln -s $HOME/.rc/d_d.zsh-theme $HOME/.oh-my-zsh/custom/themes/d_d.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Installing NEOVIM

if [[ $(command -v nvim) ]]; then
  echo "Neovim is already installed"
else
  echo "Downloading & installing neovim"
  if [[ $(command -v brew) ]]; then
    echo "Homebrew is already installed"
  else
    echo "Installing Homebrew..."
    $(/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")
  fi
  echo "Installing neovim"
  brew install neovim
fi

if [[ $(command -v pip3) ]]; then
  echo "Python 3.x is already installed"
else
  echo "Installing Miniconda Python 3.x"
  bash <(curl -s https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh)
fi

pip3 install neovim

mkdir .config
cd .config
mkdir nvim
cd nvim

ln -s $HOME/.rc/vimrc $HOME/.config/nvim/init.vim

source .zshrc

# Installing vim plugins
v +PlugInstall

cd $HOME/.config/nvim/bundle/YouCompleteMe/
./install.py --clang-completer



