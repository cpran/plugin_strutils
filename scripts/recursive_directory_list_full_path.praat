# Searches for all sub-directories under a given path, and returns a Strings
# object with the list of their names (optionally sorted).
#
# Written by Jose Joaquin Atria (15 October 2015)
#
# This script is part of the strutils plugin for CPrAN.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/strutils>
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

include ../../plugin_strutils/procedures/directory_list_full_path.proc
include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_selection/procedures/selection.proc

form Create Strings as directory list (recursive)...
  word     Name recursiveDirList
  sentence left_Path_and_match ~
  sentence right_Glob *
  integer  Max_depth 0 (=find all directories)
  boolean  Sort 1
  comment  Input source path and name match
  comment  You can use ~ at the start of the path as shorthand for home
  comment  Leave path field empty for GUI selector
endform

# max_depth is decremented on each run, and script will stop iff max_depth is 0.
# If user provides 0 (=no max depth), then on first run it will become negative,
# and never reach and end condition (which is what we want).
max_depth -= 1

@checkDirectory(left_Path_and_match$, "Read from...")
path$ = checkDirectory.name$
glob$ = right_Glob$

@directoryListFullPath(name$, path$, glob$, 0)

@saveSelectionTable()
selection = saveSelectionTable.table

root = selected("Strings")
total_subdirs = Get number of strings

# Recursively call this same script
if total_subdirs
  if max_depth
    for subdir to total_subdirs
      selectObject: root
      subdir$ = Get string: subdir
      runScript: "recursive_directory_list_full_path.praat",
        ... name$, subdir$, glob$, max_depth, 0

      # If sub-directories have been found (=a Strings object is returned), then
      # add the ID of that Strings object to the list of objects to select at
      # the end
      if numberOfSelected("Strings")
        @addToSelectionTable: selection, selected("Strings")
      endif

    endfor
  endif
else
  # If no sub-directories were found, remove the empty list
  Remove
endif

# Re-select all the Strings objects that have been found so far so they can be
# merged into a single object
@restoreSavedSelection: selection
removeObject: selection
if numberOfSelected("Strings") > 1
  @saveSelection()
  new = Append
  Rename: name$

  # Sort can only be true from the top-level script call, to ensure that the
  # Strings are only sorted once
  if sort
    runScript: "sort_strings_generic.praat", "yes", "yes"
  endif

  @restoreSelection()
  Remove
  selectObject: new
endif
