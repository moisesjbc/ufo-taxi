#!/bin/bash

VERSION=$1

if [ -z $VERSION ]; then
    echo "ERROR: No version specified"
    exit 1
fi

# Update version in game config.
sed -i "s/^const GAME_VERSION = '[0-9\.]*'$/const GAME_VERSION = '$VERSION'/g" godot-project/globals/config/config.gd

# Update version in levels.
python3 scripts/update_levels.py
