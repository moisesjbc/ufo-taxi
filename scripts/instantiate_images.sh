#!/bin/bash

# Sprites are currently generated at a size 5 times the one used for the base resolution in game (1280x720)
# so we can acomodate them in the future in case a bigger base resolution is chosen.
# This script resizes all the images to the base resolution and place them in their final locations.

DIVIDE_BY=20

convert -resize "$DIVIDE_BY%" design/ufo/ufo_body.png godot-project/gameplay/player/ufo_body.png
convert -resize "$DIVIDE_BY%" design/ufo/ufo_head.png godot-project/gameplay/player/ufo_head.png
convert -resize "$DIVIDE_BY%" design/farm/farm.png godot-project/gameplay/pickup_area/farm.png
convert -resize "$DIVIDE_BY%" design/festival/festival.png godot-project/gameplay/destination_area/festival.png
convert -resize "$DIVIDE_BY%" design/buildings/reverser/reverser.png godot-project/gameplay/buildings/reverser/reverser.png
