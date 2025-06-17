1. Create docker network:
```bash
docker network create ros
```
2. Set 'docker run' script to be executable:
```bash
chmod +x ./start_ros.sh
```
3. Set script for creating new terminal to be executable:
```bash
chmod +x ./new_terminal.sh
```
4. Go to project folder:
```bash
cd tengri_ws
```
5. Build project files:
```bash
catkin make
```
6. Source project files:
```bash
. devel/setup.bash
```
7. Launch rviz visualization:
```bash
roslaunch tengri_robot_urdf_moveit_config real_robor.launch
```
8. Open *http://localhost:8080/vnc.html* in the browser.
9. In the Rviz set **Fixed Frame** to the **world**.
10. Add new panel: **Robot Model**.
11. Add new panel: **MotionPlanning**. Now you can start planning through predefined configurations.
12. In the new terminal open docker container:
```bash
./new_terminal
```
13. Run script for tobot to follow visual markers:
```bash
rosrun tengri_robot_urdf ik_marker.py
```
14. Add new panel: **InteractiveMarkers**. Set topic to **/simple_marker/update**. Now you can move visual marker and set goals to planner.
