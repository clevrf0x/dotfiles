# Dotfiles

> This repo contains my private dotfiles managed using [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

## Setup sddm theme

> Theme located [here](https://framagit.org/MarianArlt/sddm-sugar-candy)

- Download Sugar-candy SDDM theme from [here](https://www.opendesktop.org/p/1312658).

- Execute these commands

  -

  ```bash
  sudo pacman -S --needed sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
  sudo mkdir -p /usr/share/sddm/themes
  sudo tar -xzvf ~/Downloads/sugar-candy.tar.gz -C /usr/share/sddm/themes
  sudo cp sddm.conf /etc/sddm.conf
  ```

- Change wallpaper location from `sddm.conf`

- Install `JetBrains Mono`
