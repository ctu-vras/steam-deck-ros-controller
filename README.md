# Steam Deck ROS Robot Controller

Steps done to configure Steam Deck as a ROS robot controller.

## Prepare the system

*At any time, if you are in the gaming mode, switching to desktop mode is done via the Power off menu.*

*To summon the on-screen keyboard, press STEAM+X. To hide it, press B.*

*Keep the Deck connected to a power source to prevent it from falling asleep.*

1. [Set the amount of reserved GPU memory to 4 GB](https://www.youtube.com/watch?v=3iivwka513Y&t=677s) (in Desktop mode, the auto mode somehow doesn't work and VRAM is capped at 1 GB normally).
1. Still in gaming mode, go to [Settings->Enable developer mode](https://tuxexplorer.com/how-to-enable-developer-mode-on-steam-deck) .
2. Still in gaming mode, go to [Developer->Enable Wifi power management](https://tuxexplorer.com/wifi-power-saving-mode-on-the-steam-deck) and turn it off (it lowers the performance and make SSH sessions very sluggish). This will want a reboot. Do it.
3. Switch to Desktop mode (see the notice above).
4. Tap the Steam icon in taskbar, select Settings -> Controller -> Desktop configuration. This menu allows you to configure the gamepad behavior, so that the `joy_node` can read it. Press X to browse available configs. Select Templates->Gamepad->Apply configuration. Do any other adjustments you like, but do not touch the JOYSTICK MOVE areas. You can't return these values back! What I do is configure L4 as Ctrl+R, L5 as Ctrl+C, R4 as up arrow and R5 as down arrow.
5. Open terminal (Konsole) from the KDE app menu->System.
6. Set the user's password: type `passwd` and type your password twice. Now you can use `sudo`.
7. Make the filesystem read-write: `sudo steamos-readonly disable` .
8. Enable SSH server: `sudo systemctl enable sshd.service && sudo systemctl start sshd.service` .
9. Now you can finally connect to the deck via SSH from your laptop.
10. Clone this repo into home directory of the deck user: `git clone https://github.com/ctu-vras/steam-deck-ros-controller` .
11. Symlink or copy everything from `etc` folder to the respective locations on the Steam Deck.
12. Symlink or copy everything from `home/deck` folder to your home directory.

## Install ROS Noetic

```bash
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
bash Mambaforge-$(uname)-$(uname -m).sh
# follow the install steps; when finished, open a new bash console
conda install mamba -c conda-forge
mamba create -n ros_env python=3.9
conda activate ros_env
conda config --env --add channels conda-forge
conda config --env --add channels robostack
conda config --env --add channels robostack-experimental
mamba install ros-noetic-desktop ros-noetic-image-transport-plugins
mamba install compilers cmake pkg-config make ninja catkin_tools
mamba install rosdep
rosdep init # note: do not use sudo!
rosdep update
pip install -U vcstool
```

## Create the catkin workspace

```bash
mkdir -p workspaces/deck_ws/src
cd workspaces/deck_ws/src
# choose the .repos files you want here
ln -s ~/steam-deck-ros-controller/home/deck/workspaces/deck_ws/src/jsk.repos ./
for f in *.repos; do vcs import < $f; done
conda activate ros_env # if not already in an environment
cd ..
catkin init
catkin config --extend /home/deck/mambaforge/envs/ros_env
catkin config --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
catkin config --skiplist husky_control husky_desktop husky_gazebo husky_navigation husky_simulator spot_driver sound_classification imagesift jsk_tilt_laser multi_map_server audio_video_recorder jsk_rosbag_tools jsk_recognition jsk_perception jsk_people_tracking_filter jsk_pcl_ros_utils jsk_pcl_ros jsk_recognition_utils jsk_recognition people_tracking_filter people leg_detector people_velocity_tracker people_velocity_tracker
rosdep install --from-paths src --ignore-src -r
catkin build
```
