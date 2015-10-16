# Searches for all files under a given path, and returns a Strings
# object with the list of their names (optionally sorted).
#
# This script is part of the strutils CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/strutils>
#
# The strutils plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The strutils plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with strutils. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2014, 2015 Jose Joaquin Atria

include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_selection/procedures/selection.proc

form Create Strings as file list (recursive)...
  word     Name recursiveFileList
  sentence left_Path_and_match ~
  sentence right_Glob *
  integer  Max_depth 0 (=find all files)
  boolean  Sort 1
  comment  Input source path and name match
  comment  You can use ~ at the start of the path as shorthand for home
  comment  Leave path field empty for GUI selector
endform

# Selection will hold all the Strings objects with partial results
@createEmptySelectionTable()
selection = createEmptySelectionTable.table

@checkDirectory(left_Path_and_match$, "Read from...")
path$ = checkDirectory.name$
glob$ = right_Glob$

# Make a list of all directories under path
if max_depth == 1
  runScript: "create_empty_strings.praat", name$
else
  runScript: "recursive_directory_list_full_path.praat",
    ... name$, path$, "*", max_depth - 1, 0
endif
Insert string: 1, path$
directories = selected("Strings")

# Get the list of files in each of these
total_dirs = Get number of strings
for i to total_dirs
  selectObject: directories
  subpath$ = Get string: i

  runScript: "file_list_full_path.praat",
    ... "file_list", subpath$, glob$, "no"
  @addToSelectionTable: selection, selected("Strings")

endfor
removeObject: directories

# Merge all partial Strings objects into a single object
@restoreSavedSelection: selection
new = Append
@restoreSavedSelection: selection
Remove
removeObject: selection
selectObject: new
if sort
  runScript: "sort_strings_generic.praat", "yes", "yes"
endif
Rename: name$
