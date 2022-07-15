![](https://raw.githubusercontent.com/Furdev-Group/networx/main/readme-assets/banner.png)
# Networx
## A network connectivity suite
Written in Ruby and designed with a simple ncurses style menu. 


## Table of contents 
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)

## Installation
Download the latest version from releases, the name should look something like this: ``networx-installer-latest.zip``, extract it and run ``bundle`` in the extracted folder, then run ``ruby install.rb``.

Another thing of note is that the installer will automaticlly detect your Operating system so there is no need for different installers for different Operating systems, but do keep in mind that only some Operating systems are supported and trying to install Networx on an unsupported Operating system will only result in an error.

### Installing on Windows

You must run the installer from a terminal with UAC permissions, or you will get a permission error when trying to install Networx. You must also manually add Networx to your system PATH so it can be run from anywhere: as shown [here.](https://helpdeskgeek.com/windows-10/add-windows-path-environment-variable/)

### Installing on Linux

Pre-fix the install command with your prefered permission escalation tool such as ``doas`` or ``sudo``.
Please note that Linux support is experimental and may be buggy or even broken at times.

### Installing on MacOS

``Coming soon``

## Usage
Run ``ruby main.rb`` in the folder that contains networx, or if instaled using the installer, just run ``networx`` anywhere
## Features
- Built-in internet speedtest
- Internet connectivity checker
- Network adapter listing
- Configuration wizard
