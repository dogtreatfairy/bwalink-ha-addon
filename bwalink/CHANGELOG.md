# Changelog

## [v2026.2.1] - 2026-02-14

* Pin backend build source to a fixed commit for reproducible addon builds.
* Add startup configuration validation for `bridge_ip`, `bridge_port`, and MQTT URI format.

## [v2026.2] - 2026-02-14

* Bump for backend changes.

## [v2026.1] - 2026-02-14

* Ensure `/run/service` exists before starting `socat` — stops repeated unlink errors and PTY creation failures.
* Use backend app from `dogtreatfairy/balboa_worldwide_app` during addon build.
* Include `bwa_mqtt_bridge` action discovery fix (single-value enum button properties) to restore compatibility with `mqtt-homie-homeassistant` >= 1.2.0.


## [v2025.7] - 2025-10-02

* Updated config.yaml to include AppArmor profile for Home Assistant
* Updated Balboa Logo to 2025 Logo from their Website.
* Added DOCS.md and CHANGELOG.md so users can browse documentation and changes in Home Assistant.
