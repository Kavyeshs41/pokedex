#!/bin/bash

SERVICE_NAME=$1
ARTIFACT_NAME=$2

SERVICES_DIR=/opt/$USER/services
BUILDS_DIR=/opt/$USER/builds
TMP_BUILDS_DIR=/home/$USER/.tmp/builds

# Create .tmp directory
mkdir -p $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.tmp

# unzip the build archive in .tmp
unzip -o $TMP_BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.zip \
     -d $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.tmp

# Find directory exist and delete old builds
if [ -d $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.tmp ]
then
        echo "Deleting old builds..."
        cd $BUILDS_DIR/$SERVICE_NAME/
        ls | grep -v $ARTIFACT_NAME.tmp | xargs rm -rf
fi

# Move content from Artifact tmp directory
mv $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.tmp $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME

# Remove symlink if exists
rm $SERVICES_DIR/$SERVICE_NAME || true

# Make symlink to point to latest code directory
ln -s $BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME/ $SERVICES_DIR/$SERVICE_NAME

rm $TMP_BUILDS_DIR/$SERVICE_NAME/$ARTIFACT_NAME.tar.gz