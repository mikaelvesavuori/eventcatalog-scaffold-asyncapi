#!/bin/bash

set -o pipefail

# Orchestrate the functionality
main() {
  clean
  configBuild
  npx eventcatalog generate
  configRun
  configCore
  npx eventcatalog build
}

# Erase any garbage and previous output and configurations
clean() {
  find . -name '.DS_Store' -type f -delete
  rm -rf domains && rm -rf events && rm -rf services
  cleanConfig
}

# Erase root-level configuration
cleanConfig() {
  rm -f eventcatalog.config.js
}

# Write configuration contents to start of EventCatalog config
configUpdate() {
  cat configs/baseconfig.js | cat - eventcatalog.config.js >temp && mv temp eventcatalog.config.js
}

# Use the "build" configuration
configBuild() {
  cleanConfig
  cp configs/eventcatalog.config.build.js eventcatalog.config.js
  configUpdate
}

# Use the regular "run" configuration
configRun() {
  cleanConfig
  touch eventcatalog.config.js
  configUpdate
}

# Update the EventCatalog "core" configuration with our "run" configuration
configCore() {
  rm -f .eventcatalog-core/eventcatalog.config.js
  cp configs/baseconfig.js .eventcatalog-core/eventcatalog.config.js
}

# Start
main
exit
