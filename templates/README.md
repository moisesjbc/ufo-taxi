# {{ title }}

![]({{ img }})

{{ summary }}

## Mechanics

{{ mechanics }}

## Links
{% for link in links %}
- [{{ link.text }}]({{ link.href }}){% endfor %}

## Credits and licensing
{% for credits_section in credits %}
### {{ credits_section.name }}

{% for person in credits_section.people %}- {{ people[person].name }} - <{{ people[person].web }}>
{% endfor %}{% if 'license' in credits_section %}- Licensed under [{{ licenses[credits_section.license].name }}]({{ licenses[credits_section.license].href }})
{% endif %}{% endfor %}

## Third-party
{% for third_party_section in third_party %}
### {{ third_party_section.title }}
{% for resource in third_party_section.resources %}
- {{ resource.name }} - <{{ resource.href }}>{% endfor %}
{% endfor %}

## Thanks

{% for thank in thanks %}- {{ thank.to }} - <{{ thank.href }}>
{% endfor %}

# Development info

## Scripts

Directory scripts/ includes the following utility scripts:

### devel-html.sh

Mounts a simple webserver serving the game in localhost

1. Clone repo <https://github.com/moisesjbc/godot-export>
2. Follow instructions.
3. Move godot-export.sh to /usr/bin and give it execution permission.
4. Run the script

        bash scripts/devel-html.sh

### update-version.sh

Updates version number in game (level files, main menu, etc)

        bash scripts/update-version.sh <version>

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
