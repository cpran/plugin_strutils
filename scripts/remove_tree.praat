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
include ../../plugin_strutils/procedures/directory_list_full_path.proc
include ../../plugin_strutils/procedures/file_list_full_path.proc
include ../../plugin_selection/procedures/tiny.proc

#! ~~~ params
#! in:
#!   Name: >
#!     (word) The name of the new Strings object.
#!   Path: >
#!     (sentence) The full path of the root directory for the search. If
#!     left blank a GUI selector will be presented.
#!   Glob: >
#!     (sentence) Specify the pattern to match, as used in the standard
#!     commands.
#!   Max depth: >
#!     (integer) Set the maximum depth of the search. A value of 0 (the
#!     default) looks in all subdirectories until exhausting the directory
#!     tree.
#!   Sort: >
#!     (boolean) If true, the resulting Strings object is sorted generically.
#! selection:
#!   in:
#!     strings: ~
#! ~~~
#!
#! Make a list of all matching directories under the specified directory,
#! and under any of its subdirectories (up to the specified max depth).
#!
form Remove tree...
  sentence left_Path_and_match ~
  sentence right_Glob *
  comment  Input source path and name match
  comment  You can use ~ at the start of the path as shorthand for home
  comment  Leave path field empty for GUI selector
endform

@saveSelection()

@checkDirectory(left_Path_and_match$, "Read from...")
path$ = checkDirectory.name$
glob$ = right_Glob$

strutils$ = preferencesDirectory$ + "/plugin_strutils/scripts/"
runScript: strutils$ + "recursive_file_list_full_path.praat",
  ... "files", path$, glob$, 0, "no"
files = selected("Strings")
for i to do("Get number of strings")
#   appendInfoLine: "DELETE ", Object_'files'$[i]
  deleteFile( Object_'files'$[i] )
endfor

runScript: strutils$ + "recursive_directory_list_full_path.praat",
  ... "directories", path$, glob$, 0, "no"
dirs = selected("Strings")
n = Get number of strings
for j from 0 to n - 1
  i = n - j
#   appendInfoLine: "DELETE ", Object_'dirs'$[i]
  deleteFile( Object_'dirs'$[i] - "/" )
endfor
# appendInfoLine: "DELETE ", path$
deleteFile( path$ - "/" )

removeObject: files, dirs

@restoreSelection()
