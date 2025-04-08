<!-- omit from toc -->
# Simulation suite for the UR robot family

<!-- omit from toc -->
###### The official SAM XL collection of tools to simulate and control UR robots off-line

<!-- omit from toc -->
##### Table of content

- [Introduction](#introduction)
- [Installation of the virtual robot controller](#installation-of-the-virtual-robot-controller)
  - [Virtual machine method](#virtual-machine-method)
  - [Docker method](#docker-method)
    - [Install Docker on Windows](#install-docker-on-windows)
    - [Install Docker on macOS](#install-docker-on-macos)
    - [Install Docker on Linux](#install-docker-on-linux)
  - [RoboDK installation](#robodk-installation)
- [Move and program the ursim virtual controller](#move-and-program-the-ursim-virtual-controller)
- [Move and program the RoboDK virtual twin](#move-and-program-the-robodk-virtual-twin)
- [Appendix](#appendix)
  - [File provided for the Docker installation method](#file-provided-for-the-docker-installation-method)
- [Additional features](#additional-features)
- [References](#references)


## Introduction

Simulating a robot and performing off-line programming are crucial aspects to de-risk the success of your application. It allows you to test and validate your robot's behaviour in a virtual environment, reducing the time to debug and detect errors, which can take a long time on a real robot!

This repository contains several tools and instructions on how to use Universal Robots (UR) offline simulator (ursim), a virtual controller replica of a real robot brain, capable of replicating the behaviour of a real robot one-to-one, with all features and programming capabilities of a real robot, minus the physical body of the arm!

<!-- omit from toc -->
###### Disclaimer

There are a few ways to use this repository, with increasing level of difficulty to setup the virtual environments.
The default method of installation suggests to use Docker, a more advanced software development environment setup, and a very useful and important tool to learn.

<!-- omit from toc -->
###### How to use this documentation

- The documentation here will not give you an introduction to robotics, but it will show you the minimum required to:
  - Install the virtual robot controller (two methods proposed).
  - Move and program the virtual robot from the virtual pendant.
  - Move and program a virtual twin from RoboDK.
  - Connect the virtual twin and virtual controller to test the RoboDK programs.

## Installation of the virtual robot controller

Two different installation methods are provided, using virtual machines or Docker. Both can work on any host machine, whether it is macOS, Linux or Windows.

> ⚠️ **Warning:** <br> Unfortunately, you will need an admin/root account access on your computer to make the docker installation work. So, in case you don't, please use the virtual machine installation method!

### Virtual machine method

- **Download Virtualbox VM:**
https://www.virtualbox.org/wiki/Downloads
  
  - Select from the list depending on your host machine (Windows, macOS or Linux). 

- **Download the offline simulator image from UR:**
[https://www.universal-robots.com/download/software/...](https://www.universal-robots.com/download/software-ur20ur30/simulator-non-linux/offline-simulator-e-series-and-ur20ur30-ur-sim-for-non-linux-5210/)

  - You will have to create an account to download this file.
  - The virtual machine image you need is the file calles OFFLINE SIMULATOR, E-Series and UR20/UR30 for non linux systems, v5.21. The link should direct you to this version already.

A video with step-by-step instructions for this installation method can be found [here](https://www.youtube.com/watch?v=oJGPTRlTMPM).

After this step, move to the [RoboDK installation](#robodk-installation) paragraph.


### Docker method

Docker is a tool that makes it easier to create and run applications using containers. Containers allow developers to package up an application with all the parts it needs, such as a virtual OS, libraries and other dependencies, all running within a reproducible virtual running executable.

Docker requires default selected method to virtualise the robot controller in this repository, and all the files needed to make it work are provided.

Select one of the following paragraphs based on you own host machine.

#### Install Docker on Windows

- Open a command line terminal on windows as  admin (search for `cmd`):
- Enable windows subsystems for linux (WSL):
`wsl --install`
- Restart the computer
- Make sure that WSL version 2 is installed correctly:
`wsl --version` should be 2.x.
  - If not, make sure to run `wsl --update`
- Install Docker desktop: [link to official install instructions.](https://docs.docker.com/desktop/setup/install/windows-install/)
- Restart your computer
- Run the Computer Management as an admin and go to "Local Users and Groups."
- From there, go to "Groups" and then go to "docker-users."
- Right-click to add the user into the group.
- Restart your computer for the changes to take place.

#### Install Docker on macOS

[Link to official install instructions.](https://docs.docker.com/desktop/setup/install/mac-install/)

#### Install Docker on Linux

Please select your distribution from the list on the [official install instructions](https://docs.docker.com/engine/install/) and proceed.

### RoboDK installation

Please, install RoboDK on your machine from this link:
https://robodk.com/download

If you installed the virtual UR controller using the virtual machine method, please follow the official RoboDK instructions here:
https://robodk.com/doc/en/Robots-Universal-Robots-URSim-Installation-guide.html

## Move and program the ursim virtual controller

Independently of which installation method you used, we will be here showing some basics user instructions and programming steps for the UR16
You can now try out 

## Move and program the RoboDK virtual twin


## Appendix

### File provided for the Docker installation method

If you intend to use on your real robot, please make sure you use the correct [official ursim tag](https://hub.docker.com/r/universalrobots/ursim_e-series/tags) corresponding to you phisical controller Polyscope version. 

Please change the `.env` file to match you setup parameters:

| Parameter              | Description                                                     |
| ---------------------- | --------------------------------------------------------------- |
| `ROBOT_MODEL=UR5`      | Robot model to simulate: `UR3`, `UR5` (default), `UR10`, `UR16` |
| `POLYSCOPE=5.11.11`    | Polyscope software version                                      |
| `TZ=Europe/Copenhagen` | Timezone to use. Defaults to Europe/Copenhagen.                 |

To use with official [ROS drivers](https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver), the official [URCap external-control plugin](https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap) needs to be installed while building the image.
TODO
**Currently not working, the file sha is corrupted or something?**
More info here: https://docs.ros.org/en/ros2_packages/rolling/api/ur_robot_driver/user_docs/installation/install_urcap_e_series.html#install-urcap-e-series


## Additional features

TODO
| Port       | Function                                                           |
| ---------- | ------------------------------------------------------------------ |
| `-p 5900`  | Allows VNC access to the robots interface.                         |
| `-p 502`   | Allows access to Universal Robots Modbus port.                     |
| `-p 29999` | Allows access to Universal Robots dashboard server interface port. |
| `-p 30001` | Allows access to Universal Robots primary interface port.          |
| `-p 30002` | Allows access to Universal Robots secondary interface port.        |
| `-p 30003` | Allows access to Universal Robots real-time interface port.        |
| `-p 30004` | Allows access to Universal Robots RTDE interface port.             |

## References

- [Setup URSim with Docker](https://docs.ros.org/en/rolling/p/ur_client_library/doc/setup/ursim_docker.html)
- TODO