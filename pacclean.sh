sudo pacman -Scc --noconfirm
sudo pacman -Rns $(pacman -Qtdq)
sudo paccache -r
