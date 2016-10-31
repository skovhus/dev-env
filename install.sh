#!/bin/bash

# Inspiration:
# - http://fredkelly.net/articles/2014/10/19/developing_on_yosemite.html
# - https://github.com/sorenvind/dev-env
# - https://github.com/mads-hartmann/dotfiles

# Set up OSX settings
echo "> Setting up OS X..."
./OSXsettings.sh

# Install homebrew and cask
if test ! $(which brew)
then
  echo "> Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew install caskroom/cask/brew-cask
fi

# Install latest zsh and oh-my-zsh
OMZ=~/.oh-my-zsh
if test ! -d $OMZ
then
  echo "> Installing oh my zsh..."
  brew install zsh
  curl -L http://install.ohmyz.sh | sh
fi

# Install common sanity
echo "> Installing common sanity..."
brew tap homebrew/dupes
brew update
brew upgrade
brew install coreutils
brew install make
brew install gnu-sed
brew install wget
brew install curl
brew install go
brew install node
brew install python
brew install ruby
brew install git
brew install mercurial
brew install tree
brew install pstree
brew install the_silver_searcher
brew install jq

# Install python packages
pip install requests virtualenv

# Symlink dot files
ln -fs $PWD/home/.zshrc ~
cp home/.gitconfig ~  # e-mail not in git

# And oh my zsh theme
mkdir -p ~/.oh-my-zsh/themes/
ln -fs $PWD/skovhus.zsh-theme ~/.oh-my-zsh/themes/skovhus.zsh-theme

# Install Apps
echo "> Installing Apps you will like..."
brew cask install google-chrome
brew cask install atom
brew cask install sublime-text
brew cask install gitup
brew cask install moom
brew cask install dropbox
brew cask install flux
brew cask install jumpcut
brew cask install licecap
brew cask install omnigraffle
brew cask install spotify
brew cask install docker

# Atom packages
echo "> Setting up Atom..."
apm install `cat atom-packages.list`
cp .atom/config.cson ~/.atom/

# Sublime
echo "> Setting up Sublime"
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
cp Sublime/User/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/

echo "> Done!"

echo "-----------------------------------------"
echo "Manual steps:"
echo "-----------------------------------------"
echo "- Setup terminal to import solazried-dark theme, with Menlo Regular 10pt and block cursor."
echo "- ensure ~/.gitconfig is correct"
echo "- Fix all issues from running brew doctor"
echo "- Set up short cuts http://apple.stackexchange.com/questions/167967/creating-system-wide-keyboard-shortcut-to-launch-applications"
echo "- Open Sublime and install Package Control"
