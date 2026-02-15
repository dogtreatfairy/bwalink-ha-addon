#!/usr/bin/with-contenv bashio

bashio::log.info "Starting BWALink addon..."

BRIDGE_IP=$(bashio::config 'bridge_ip')
BRIDGE_PORT=$(bashio::config 'bridge_port')
export TZ=$(bashio::info.timezone)
export LOG_LEVEL=$(bashio::config 'log_level')

bashio::log.info "Setting addon timezone to ${TZ} based on the system timezone."

if ! bashio::config.has_value 'bridge_ip'; then
    bashio::log.error "Missing required configuration: bridge_ip"
    exit 1
fi

if ! [[ "${BRIDGE_PORT}" =~ ^[0-9]+$ ]] || (( BRIDGE_PORT < 1 || BRIDGE_PORT > 65535 )); then
    bashio::log.error "Invalid bridge_port '${BRIDGE_PORT}'. Expected an integer between 1 and 65535."
    exit 1
fi

if bashio::config.has_value 'mqtt_uri'; then
    MQTT_URI=$(bashio::config 'mqtt_uri')
# no mqtt config is supplied, so let's use the mqtt addon config
elif bashio::var.has_value "$(bashio::services 'mqtt')"; then
    MQTT_USER="$(bashio::services 'mqtt' 'username')"
    MQTT_PASSWORD="$(bashio::services 'mqtt' 'password')"
    if bashio::var.true "$(bashio::services 'mqtt' 'ssl')"; then
        MQTT_URI="mqtts://${MQTT_USER}:${MQTT_PASSWORD}@$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    else
        MQTT_URI="mqtt://${MQTT_USER}:${MQTT_PASSWORD}@$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    fi
else
    bashio::log.error "No MQTT configuration found. Exiting..."
    exit 1
fi

if ! [[ "${MQTT_URI}" =~ ^mqtts?:// ]]; then
    bashio::log.error "Invalid MQTT URI '${MQTT_URI}'. Expected URI to start with mqtt:// or mqtts://"
    exit 1
fi

DEVICE=/run/service/hottub
if bashio::var.true "$(bashio::config 'socat')"; then
    # Ensure the directory exists (no longer auto-created since HA addons -> apps migration)
    mkdir -p /run/service
    bashio::log.info "Starting socat connecting ${DEVICE} to ${BRIDGE_IP}:${BRIDGE_PORT}"
    #Start-up socat to bind the remote serial to IP relay to a virtual port on /run/service/hottub
    socat pty,link=${DEVICE},b115200,raw,echo=0 tcp4:${BRIDGE_IP}:${BRIDGE_PORT},forever,interval=10,fork &
else
    DEVICE="tcp://${BRIDGE_IP}:${BRIDGE_PORT}/"
fi

# Resolve bridge script path from installed gem and run it with ruby.
# This avoids the RubyGems wrapper path where __FILE__ != $PROGRAM_NAME.
BWA_BRIDGE_SCRIPT=$(ruby -e 'spec = Gem::Specification.find_by_name("balboa_worldwide_app"); print File.join(spec.gem_dir, "exe", "bwa_mqtt_bridge")' 2>/dev/null || true)

if [ -z "${BWA_BRIDGE_SCRIPT}" ] || [ ! -f "${BWA_BRIDGE_SCRIPT}" ]; then
    bashio::log.fatal "Cannot resolve bwa_mqtt_bridge script from gem installation"
    bashio::log.error "Installed gems:"
    gem list 2>&1 | while read -r line; do bashio::log.error "  ${line}"; done
    exit 1
fi

bashio::log.info "Using bridge script: ${BWA_BRIDGE_SCRIPT}"
bashio::log.info "Starting mqtt bridge connecting ${DEVICE} to ${MQTT_URI/:*@/://}"

exec ruby "${BWA_BRIDGE_SCRIPT}" "${MQTT_URI}" "${DEVICE}" 2>&1