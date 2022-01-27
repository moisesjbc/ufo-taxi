#!/usr/bin/env python3

import os
import sys
import json

def gen_buildings(building_type, building_positions):
    buildings = []
    for building_position in building_positions:
        buildings.append({
            'type': building_type,
            'position': building_position
        })
    return buildings
    

if __name__ == '__main__':
    new_game_version = sys.argv[1]

    dir_path = os.path.join('godot-project', 'levels', 'campaign')
    for level_filename in os.listdir(dir_path):
        level_file_path = os.path.join(dir_path, level_filename)
        print('level_file_path', level_file_path)
        if os.path.isfile(level_file_path):
            with open(level_file_path, 'r') as level_file:
                level_data = json.load(level_file)
                if level_data['version'] == '0.4':
                    # In 0.4 buildings were separated in different arrays per type. Move them all to "buildings".
                    if 'buildings' not in level_data:
                        level_data['buildings'] = []
                    
                    if 'pickup_area_positions' in level_data:
                        level_data['buildings'] += gen_buildings('farm', level_data['pickup_area_positions'])
                        del level_data['pickup_area_positions']

                    if 'area_51_positions' in level_data:
                        level_data['buildings'] += gen_buildings('area_51', level_data['area_51_positions'])
                        del level_data['area_51_positions']

                level_data['version'] = new_game_version

                with open(level_file_path, 'w') as output_level_file:
                    json.dump(level_data, output_level_file, indent=4)
