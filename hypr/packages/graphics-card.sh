#/bin/bash

echo "
#########################################################
#                                                       #
#            Which Graphics Card do you have?           #
#                                                       #
#########################################################

1) Intel
2) AMD
3) Nvidia
Defaults to AMD if you choose
something else
"
echo ""
read GRAPHICSCARD
case $GRAPHICSCARD in
1)
  sudo pacman -S --noconfirm xf86-video-intel mesa vulkan-intel vulkan-intel
  sudo dracut-rebuild;;
2)
  sudo pacman -S --noconfirm xf86-video-amdgpu mesa vulkan-radeon vdpauinfo corectrl libvdpau vdpauinfo
  sudo dracut-rebuild;;
3)
  sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3'/GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3 nvidia_drm.modeset=1 nvidia_drm.fbdev=1'' /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  sudo cp -r ~/garuda-dots/dracut/nvidia.conf /etc/dracut.conf.d
  sudo cp -r ~/garuda-dots/nvidia/grub /etc/default
  sudo pacman -S --noconfirm sudo pacman -S nvidia-dkms vulkan-validation-layers nvidia-prime nvidia-settings glxgears qt5-wayland qt5ct qt6-wayland qt6ct libva && yay --noconfirm -S libva-nvidia-driver-git
  sudo dracut-rebuild;;
*)
  sudo pacman -S --noconfirm xf86-video-amdgpu mesa vulkan-radeon vdpauinfo corectrl libvdpau vdpauinfo
  sudo dracut-rebuild;;
esac
echo ""
clear
echo "
#########################################################
#                                                       #
#         Your Graphics Card has been installed         #
#                                                       #
#########################################################
"