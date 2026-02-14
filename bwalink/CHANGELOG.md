# Changelog

## [v2026.1] - 2026-02-14

* Ensure `/run/service` exists before starting `socat` — stops repeated unlink errors and PTY creation failures.
* Pin `mqtt-homie-homeassistant` to `~> 1.1.0` to avoid `hass_button` validation crash (workaround for upstream incompatibility).


## [v2025.7] - 2025-10-02

* Updated config.yaml to include AppArmor profile for Home Assistant
* Updated Balboa Logo to 2025 Logo from their Website.
* Added DOCS.md and CHANGELOG.md so users can browse documentation and changes in Home Assistant.
