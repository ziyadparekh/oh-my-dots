#
# Application installer (via brew-cask)
#

set -e

# Apps
apps=(
  alfred
  google-chrome
  qlcolorcode
  screenflick
  firefox
  hazel
  qlmarkdown
  spotify
  vagrant
  arq
  flash
  iterm2
  qlprettypatch
  sublime-text3
  virtualbox
  flux
  qlstephen
  tower
  vlc
  font-m-plus
  nvalt
  quicklook-json
  skype
  transmission
  apikitchen
  sequel-pro
  github
  bettertouchtool
  dash
  caffeine
  boot2docker
)

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-roboto
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew tap phinze/homebrew-cask
  brew install brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
