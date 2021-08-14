#!/bin/bash

# Build for web.
godot-export.sh "ufo-taxi" "devel" "HTML5"

# Get public IP.
dig +short myip.opendns.com @resolver1.opendns.com

# Serve game.
(cd export/ufo-taxi_html/ && python3 -m http.server 8000)
