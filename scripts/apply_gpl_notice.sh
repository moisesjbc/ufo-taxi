#!/bin/bash

read -r -d '' GPL_NOTICE << EOM

EOM


apply_gpl_to_file() {
    FILEPATH=$1

    GPL_NOTICE='"""
Copyright 2020-2022 Moisés J. Bonilla Caraballo (moisesjbc)

This file is part of "UFO taxi!".

"UFO taxi!" is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

"UFO taxi!" is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with "UFO taxi!".  If not, see <https://www.gnu.org/licenses/>.
"""
'
    
    CONTAINS_LICENSE=`head -n 1 $FILEPATH | grep '"""'`
    if [ -z "$CONTAINS_LICENSE" ]; then
        echo "$GPL_NOTICE" | cat - $FILEPATH > /tmp/gpl_tmp
        mv /tmp/gpl_tmp "$FILEPATH"
    else
        perl -i -p0e "s|^\"\"\".*?\"\"\"\n|$GPL_NOTICE|sg" "$FILEPATH"
    fi
}
export -f apply_gpl_to_file

 find . -name *.gd -exec bash -c "apply_gpl_to_file {}" \;
