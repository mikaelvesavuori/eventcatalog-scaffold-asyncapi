#!/bin/bash

read -p "Enter catalog (folder) name: " CATALOG

if [ -z $CATALOG ]; then
  echo "Missing catalog name!"
  exit 1
fi

function main() {
  createNewCatalog
  addConfigs
  addSchemas
  cd $CATALOG
  installAsyncApiSupport
  removeDemoMaterials
}

function createNewCatalog() {
  npx @eventcatalog/create-eventcatalog@latest $CATALOG
}

function installAsyncApiSupport() {
  npm install -D @eventcatalog/plugin-doc-generator-asyncapi
}

function removeDemoMaterials() {
  rm -rf domains
  rm -rf events
  rm -rf services
}

function addConfigs() {
  cp build-eventcatalog.sh $CATALOG
  cp -r configs $CATALOG
}

function addSchemas() {
  cp -r schemas $CATALOG
}

# Start
main
exit
