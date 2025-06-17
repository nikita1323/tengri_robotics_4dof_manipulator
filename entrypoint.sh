#!/bin/bash

set -e

# sudo apt update && sudo apt upgrade -y

# sudo mkdir -p /etc/ros/rosdep/sources.list.d/
# sudo curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.bfsu.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list
# export ROSDISTRO_INDEX_URL=https://mirrors.bfsu.edu.cn/rosdistro/index-v4.yaml

# rosdep update
# sudo apt-get update
# sudo apt-get dist-upgrade -y
# sudo apt-get install ros-melodic-moveit -y

source opt/ros/melodic/setup.bash

echo "Provided arguments: $@"

exec $@
