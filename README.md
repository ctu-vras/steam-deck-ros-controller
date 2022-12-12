# Steam Deck ROS Robot Controller

Steps done to configure Steam Deck as a ROS robot controller.

## Prepare the system

*At any time, if you are in the gaming mode, switching to desktop mode is done via the Power off menu.*

*To summon the on-screen keyboard, press STEAM+X. To hide it, press B.*

1. Still in gaming mode, go to [Settings->Enable developer mode](https://tuxexplorer.com/how-to-enable-developer-mode-on-steam-deck) .
2. Still in gaming mode, go to [Developer->Enable Wifi power management](https://tuxexplorer.com/wifi-power-saving-mode-on-the-steam-deck) and turn it off (it lowers the performance and make SSH sessions very sluggish). This will want a reboot. Do it.
3. Switch to Desktop mode (see the notice above).
4. Tap the Steam icon in taskbar, select Settings -> Controller -> Desktop configuration. This menu allows you to configure the gamepad behavior, so that the `joy_node` can read it. Press X to browse available configs. Select Templates->Gamepad->Apply configuration. Do any other adjustments you like, but do not touch the JOYSTICK MOVE areas. You can't return these values back! What I do is configure L4 as Ctrl+R, L5 as Ctrl+C, R4 as up arrow and R5 as down arrow.
5. Open terminal (Konsole) from the KDE app menu->System.
6. Set the user's password: type `passwd` and type your password twice. Now you can use `sudo`.
7. Make the filesystem read-write: `sudo steamos-readonly disable` .
8. Enable SSH server: `sudo systemctl enable sshd.service && sudo systemctl start sshd.service` .
9. Now you can finally connect to the deck via SSH from your laptop.
