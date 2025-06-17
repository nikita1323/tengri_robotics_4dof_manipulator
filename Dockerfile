FROM osrf/ros:melodic-desktop-full

# Create a non-root user
ARG USERNAME=ros
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && mkdir /home/$USERNAME/.config && chown $USER_UID:$USER_GID /home/$USERNAME/.config

  
# Set up sudo
RUN apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install python3-serial -y
RUN rm -rf /var/lib/apt/lists/*

RUN usermod -aG dialout ${USERNAME}

RUN apt-get update
RUN apt-key del 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN sudo -E apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN sh \
      -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" \
        > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-get update
RUN apt-get install -y ros-melodic-rosserial
RUN apt-get install -y ros-melodic-rosserial-arduino
RUN apt-get install -y ros-melodic-rosserial-python
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y ros-melodic-catkin
RUN apt-get install -y python3-catkin-tools
RUN apt-get install -y python3-vcstool
RUN apt-get install ros-melodic-joint-state-publisher-gui
RUN rm -rf /var/lib/apt/lists

RUN apt update && sudo apt upgrade -y
RUN mkdir -p /etc/ros/rosdep/sources.list.d/
RUN curl -o /etc/ros/rosdep/sources.list.d/20-default.list https://mirrors.bfsu.edu.cn/github-raw/ros/rosdistro/master/rosdep/sources.list.d/20-default.list
RUN export ROSDISTRO_INDEX_URL=https://mirrors.bfsu.edu.cn/rosdistro/index-v4.yaml

USER ros
RUN rosdep update
RUN sudo apt-get update
RUN sudo apt-get dist-upgrade -y
RUN sudo apt-get install ros-melodic-moveit -y
RUN sudo apt-get install ros-melodic-ros-control ros-melodic-ros-controllers -y

# ADD ["src", "tengri_ws/src"]
# Copy the entrypoint and bashrc scripts so we have 
# our container's environment set up correctly
COPY entrypoint.sh /entrypoint.sh
# COPY entrypoint_roscore.sh /entrypoint_roscore.sh


# Set up entrypoint and default command
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
# CMD ["bash"]