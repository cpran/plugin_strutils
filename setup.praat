# Setup script for strutils
#
# Find the latest version of this plugin at
# https://gitlab.com/cpran/plugin_strutils
#
# Written by Jose Joaquín Atria
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

## Static commands:

# Uncomment next line to run tests at startup
# runScript: "run_tests.praat"

# Base menu
nocheck Add menu command: "Objects", "New", "Create Strings as file list (full path)...", "", 0, "scripts/file_list_full_path.praat"
nocheck Add menu command: "Objects", "New", "Create empty Strings...",                    "", 0, "scripts/create_empty_strings.praat"

## Dynamic commands

# Strings commands
Add action command: "Strings",  0, "",         0, "", 0, "Sort (generic)...",                    "Modify -",              1, "scripts/sort_strings_generic.praat"
Add action command: "Strings",  0, "",         0, "", 0, "Replace strings...",                   "Modify -",              1, "scripts/replace_strings.praat"
Add action command: "Strings",  0, "",         0, "", 0, "Extract strings...",                   "",                      0, "scripts/extract_strings.praat"
Add action command: "Strings",  0, "",         0, "", 0, "Find in Strings...",                   "Query -",               1, "scripts/find_in_strings.praat"
