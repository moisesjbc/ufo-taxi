#!/bin/bash

# Sprites are currently generated at a size 5 times the one used for the base resolution in game (1280x720)
# so we can acomodate them in the future in case a bigger base resolution is chosen.
# This script resizes all the images to the base resolution and place them in their final locations.

DIVIDE_BY=20

convert -resize "$DIVIDE_BY%" ufo/ufo_body.png ../godot-project/gameplay/player/ufo_body.png
convert -resize "$DIVIDE_BY%" ufo/ufo_head.png ../godot-project/gameplay/player/ufo_head.png
