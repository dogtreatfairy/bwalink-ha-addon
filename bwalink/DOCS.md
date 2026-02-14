# BWALink Home Assistant Add-on

[![Release][release-shield]][release] ![Project Maintenance][maintenance-shield] [![Changelog][changelog-shield]][changelog]

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

<img src="https://raw.githubusercontent.com/dogtreatfairy/bwalink-ha-addon/main/bwalink/balboa_logo.png" width="150" alt="Logo">

## Credit
1. Thanks to the great work from jshank (https://github.com/jshank/bwalink) getting this working as a Local (manual) Add-on.
2. Thanks to ccutrer for the backend (https://github.com/dogtreatfairy/balboa_worldwide_app) and figuring out the interface.

## Purpose
To expand on the work of jshank and ccutrer and simplify the Home Assistan install and update process. And when I say expand, what I really mean is to copy it to a new repository and move files around so Home Assistant is happy, because there is no planet on which I could have built any of this on my own. 

## Overview
BWALink is an add-on for Home Assistant that allows you to connect and control Balboa Water Group spa controllers using a serial-to-IP gateway and MQTT. This enables seamless integration of your spa with Home Assistant, providing access to sensors and switches for spa features.

## Features
- Connects Balboa spa controllers to Home Assistant via MQTT
- Supports aarch64, amd64, armhf, armv7, and i386 architectures
- Provides sensors and switches for spa control
- Simple configuration using MQTT Discovery

## Getting Started
1. Follow the excellent instructions on the original BWA Link GitHub to get the hardware up and running. The EW11 routes is the simplest and cheapest. 
2. In Home Assistant, ensure sure you have an MQTT broker (such as mosquitto) set up and running. 
3. Install the BWALink add-on in Home Assistant through the addon menu.

## Installation
1. In the `Add-On Menu`, click the `Add-On Store` in the bottom right.
2. Click the `︙` on the top right and click `Repositories`
3. Paste in the bwalink-ha-addon repository url: https://github.com/dogtreatfairy/bwalink-ha-addon
4. Click the `︙` on the top right and click `Check for Updates`
5. BWALink Add-On should be available to install. You might have to scroll down.
6. Once installed, configure the add-on with your spa's IP address. You shouldn't need the MQTT URI, but some home assistant installs need it. 

## Home Assistant Integration
If MQTT Discovery is enabled in Home Assistant, BWALink will automatically create entities for your spa's sensors and switches. No manual configuration is required.

### Configuration Options
- `bridge_ip`: The IP address of your serial-to-IP gateway.
- `bridge_port`: The port of your serial-to-IP gateway (default: 8899).
- `mqtt_uri`: The URI of your MQTT broker.
  - ```mqtt://username:password@mqtt-broker-ip:1883```
- `socat`: Advanced socat options.
- `log_level`: Set the log level for the add-on.



For more details, visit the [jshank BWALink GitHub repository](https://github.com/jshank/bwalink).

[logo]: https://raw.githubusercontent.com/dogtreatfairy/bwalink-ha-addon/main/bwalink/balboa_logo.png
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg
[release-shield]: https://img.shields.io/badge/version-v2026.1-blue.svg
[release]: https://github.com/dogtreatfairy/bwalink-ha-addon/releases/tag/2026.1
[changelog-shield]: https://img.shields.io/badge/changelog-v2026.1-orange.svg
[changelog]: https://github.com/dogtreatfairy/bwalink-ha-addon/blob/main/bwalink/CHANGELOG.md