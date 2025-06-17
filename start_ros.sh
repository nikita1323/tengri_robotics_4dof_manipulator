echo "********************"
echo "---Starting novnc---"
echo "********************\\n"

docker run -d --rm --net=ros \
   --env="DISPLAY_WIDTH=2560" --env="DISPLAY_HEIGHT=1440" --env="RUN_XTERM=no" \
   --name=novnc -p=8080:8080 \
   theasp/novnc:latest

echo "********************"
echo "--Starting roscore--"
echo "********************\\n"

docker run -d --net=ros --name roscore --user=ros --env="ROS_MASTER_URI=http://roscore:11311" tengri_robot_image roscore

echo "********************"
echo "----Starting ros----"
echo "********************\\n"

docker run -it --net=ros \
   --env="ROS_MASTER_URI=http://roscore:11311" \
   --env "QT_X11_NO_MITSHM=1" \
   --volume /dev:/dev \
   --env="DISPLAY=novnc:0.0" \
   --env LIBGL_ALWAYS_SOFTWARE=1 \
   --device=/dev/ttyACM0 \
   --volume /tmp/.X11-unix:/tmp/.X11-unix \
   -v $PWD:/tengri_ws \
   --gpus all \
   --rm \
   --user=ros --name=tengri_robot_container tengri_robot_image bash