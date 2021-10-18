// Copyright (c) 2017, NVIDIA CORPORATION. All rights reserved.
// Full license terms provided in LICENSE.md file.

/**
    osdk_controller ROS node. Implements simple waypoint based controller for OSDK/Mavros flightstack.
    It accepts input from either game controllers (Xbox and Shield) or from DNN that decides
    what direction the drone should fly. Once control signal is received it sets a waypoint at the
    right distance in correct direction. Also, allows finer grain controls over drone position.
    Authors/maintainers: Nikolai Smolyanskiy, Alexey Kamenev
*/

#include <ros/ros.h>
#include "osdk_controller/osdk_controller.h"

int main(int argc, char **argv)
{
    ROS_INFO("Starting osdk_controller ROS node...");

    ros::init(argc, argv, "osdk_controller");
    ros::NodeHandle nh("~");

    osdk_control::osdkController controller;
    if(!controller.init(nh))
    {
        ROS_ERROR("Could not initialize osdkController node!");
        return -1;
    }

    if(!controller.arm())
    {
        ROS_ERROR("Could not arm osdk/FCU!");
        return -1;
    }

    // Loop and process commands/state
    controller.spin();

    return 0;
}
