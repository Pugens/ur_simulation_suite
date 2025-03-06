<!-- omit from toc -->
# Simulation suite for the UR robot family

<!-- omit from toc -->
###### THE OFFICIAL SAM XL COLLECTION OF TOOLS TO SIMULATE AND CONTROL UR ROBOTS OFF-LINE

<!-- omit from toc -->
##### Table of content

- [Introduction](#introduction)
        - [Disclaimer](#disclaimer)
- [Installation](#installation)
  - [Virtual machines method](#virtual-machines-method)
  - [Docker method](#docker-method)
    - [Install Docker on Windows](#install-docker-on-windows)
    - [Install Docker on macOS](#install-docker-on-macos)
    - [Install Docker on Linux](#install-docker-on-linux)
  - [RoboDK](#robodk)
- [Use the suite with provided Docker files](#use-the-suite-with-provided-docker-files)
- [Other references](#other-references)
- [RoboDK](#robodk-1)
- [References](#references)

## Introduction

Simulating a robot and performing off-line programming are crucial aspects to de-risk the success of your application. It allows you to test and validate your robot's behaviour in a virtual environment, reducing the time to debug and detect errors, which can take a long time on a real robot!

This repository contains several tools and instructions on how to use Universal Robots (UR) offline simulator (ursim), a virtual controller replica of a real robot brain, capable of replicating the behaviour of a real robot 1-to-1, with all features and programming capabilities of a real robot, minus the physical body of the arm!

###### Disclaimer

There are a few ways to use this repository, with increasing level of difficulty to setup the virtual environments.
The default method of installation suggests to use Docker, a more advanced software development environment setup, and a very useful and important tool to learn.

###### These docs
- The documentation here will not give you an introduction to robotics, but it will show you the minimum required to:
  - Install the required virtualisation tools to run the digital robot controller replica, whether you select a virtual machine or Docker.
  - Move and program the virtual robot from the virtual pendant.
  - Move and program a virtual twin from RoboDK.
  - Connect the virtual twin and virtual controller to test the RoboDK programs.

## Installation

Two different installation methods are provided, using virtual machines or Docker. Both can work on any host machine, whether it is macOS, Linux or Windows. Just follow the instructions below for one of the two methods

### Virtual machines installation method

- **Download Virtualbox VM:**
https://www.virtualbox.org/wiki/Downloads
  
  - Select from the list depending on your host machine (Windows, macOS or Linux). 

- **Download the offline Simulator:**
[https://www.universal-robots.com/download/software/...](https://www.universal-robots.com/download/software-ur20ur30/simulator-non-linux/offline-simulator-e-series-and-ur20ur30-ur-sim-for-non-linux-5210/)

  - You will have to create an account to download this file.
  - The virtual machine image you need is the file calles OFFLINE SIMULATOR, E-Series and UR20/UR30 for non linux systems, v5.21. The link should direct you to this version already.

A nice video with the instructions step-by-step for this intallation type can be found [here](https://www.youtube.com/watch?v=oJGPTRlTMPM).
An alternative step-by-step procedure can be found [here](https://www.youtube.com/watch?v=ncZJQKL4Fxo).

### Docker installation method
Docker compose is the default selected method to virtualise the robot controller in this repository, and all the files needed to make it work are provided. Docker makes it easier to create and run applications using containers. Containers allow a developer to package up an application with all the parts it needs, such as a starting OS, libraries and other dependencies, all running within a reproducible virtual running executable.

#### Install Docker on Windows
- Enable WSL 2 from the command line terminal (`cmd`):
`wsl --install`
- Restart the computer
- Make sure that WSL 2 is installed correctly:
`wsl --version` should be 2.x. If not, make sure to run `wsl --update`
- Set your wsl to a 

#### Install Docker on macOS
https://docs.docker.com/desktop/setup/install/mac-install/

#### Install Docker on Linux
Please select your distribution from the list here and proceed:
https://docs.docker.com/engine/install/

If you intend to use on your real robot, please make sure you use the correct [official ursim tag](https://hub.docker.com/r/universalrobots/ursim_e-series/tags) corresponding to you phisical controller Polyscope version. 


### Use the provided files with a docker installation

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

### RoboDK installation
Please, install RoboDK is not already present on your machine:
https://robodk.com/download

You can also see the official RoboDK instructions to work with 
https://robodk.com/doc/en/Robots-Universal-Robots-URSim-Installation-guide.html

## Move and program the ursim virtual controller

## Move and program the RoboDK virtual twin

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