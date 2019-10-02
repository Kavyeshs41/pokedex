#!/bin/bash

SERVICE_NAME=$1

BUILDS_DIR=/opt/$USER/builds

sudo mkdir -p $BUILDS_DIR/$SERVICE_NAME

sudo cp -R build/ $BUILDS_DIR/$SERVICE_NAME

sudo chown -R www-data:www-data $BUILDS_DIR/$SERVICE_NAME

sudo rm -rf ~/.tmp/