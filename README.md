# UFO taxi!

![](https://raw.githubusercontent.com/moisesjbc/ufo-taxi/main/multimedia/screenshot.png)

Puzzle game where the player has to take cows to a festival by modifying a traveling path. Developed with [Godot](https://godotengine.org/) for the [Ludum Dare #47](https://ldjam.com/events/ludum-dare/47). - Theme: "Stuck in a loop"


## Mechanics

The goal on each level is to modify the path followed by the UFO so it can pick cows from the farms and leave them at the festival.

- Click on a vertex and confirm for removing it.
- Drag and drop an edge for creating a new vertex.


## Links

- [Play "UFO Taxi!" online,](https://www.moisesjose.com/games/ufo-taxi/play)
- [Download "UFO taxi!" v0.3.1 for Windows,](https://github.com/moisesjbc/ufo-taxi/releases/download/v0.3.1/ufo-taxi_windows_v0.3.1.zip)
- [Download "UFO taxi!" v0.3.1 for GNU/Linux](https://github.com/moisesjbc/ufo-taxi/releases/download/v0.3.1/ufo-taxi_linux_v0.3.1.zip)
- ["UFO taxi!" page at Ludum Dare #47](https://ldjam.com/events/ludum-dare/47/ufo-taxi)
- [\"UFO taxi!\" page at itch.io](https://moisesjbc.itch.io/ufo-taxi)
- [\"UFO taxi!\" Github repository](https://github.com/moisesjbc/ufo-taxi)

## Credits and licensing

### Idea and game design

- Moisés J. Bonilla Caraballo (moisesjbc) - <https://moisesjose.com>

### Programming

- Moisés J. Bonilla Caraballo (moisesjbc) - <https://moisesjose.com>
- Licensed under [GPL v3](https://www.gnu.org/licenses/gpl-3.0.html)

### Graphics

- Moisés J. Bonilla Caraballo (moisesjbc) - <https://moisesjose.com>
- Licensed under [Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0/)

### Music

- Alejandro Sánchez Medina (alejandrosame) - <https://github.com/alejandrosame>
- Licensed under [Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0/)

### SFX

- Alejandro Sánchez Medina (alejandrosame) - <https://github.com/alejandrosame>
- Moisés J. Bonilla Caraballo (moisesjbc) - <https://moisesjose.com>
- Licensed under [Attribution-NonCommercial-ShareAlike 4.0 International](http://creativecommons.org/licenses/by-nc-sa/4.0/)


## Third-party

### Software

- Godot Engine - <https://godotengine.org/>
- GIMP - <https://www.gimp.org/>
- sfxr - <https://www.drpetter.se/project_sfxr.html>
- LMMS - <https://lmms.io/>
- FoxDot - <https://foxdot.org/>
- REAPER - <https://www.reaper.fm>

### Fonts

- Ubuntu font - <https://design.ubuntu.com/font/>


## Thanks

- The Ludum Dare organizers - <https://ldjam.com/>
- The people who rated and comented my game on Ludum Dare #47 and encouraged me to extend it - <https://ldjam.com/events/ludum-dare/47/ufo-taxi>
- LeninGamers (Adrián, Christian and Omar) - <https://www.twitch.tv/leningamers>
- Himar - <https://www.facebook.com/sobrelamarcharockbandcovers>


# Development info

## Scripts

Directory scripts/ includes the following utility scripts:

### devel-html.sh

Mounts a simple webserver serving the game in localhost

        bash scripts/devel-html.sh

### update-version.sh

Updates version number in game (level files, main menu, etc)

        bash scripts/update-version.sh <version>

ie.

        bash scripts/update-version.sh 0.5

### Instantiate images (Ubuntu)

Sprites are created with a size N times bigger than the base resolution used in the game. This script reduces the sprites to the base resolution and place them in their corresponding directories in the Godot project directory:

        bash scripts/instantiate_images.sh

### Add GPL legal notices

Add the GPL legal notice to the begining of all source files (.gd)

        bash scripts/apply_gpl_notice.sh

### Generate this README from template

Requires Python3 and the following dependencies:

        pip install pyyaml jinja2

Generate this README from template:

        python scripts/gen_templates.py templates/README.md > README.md
