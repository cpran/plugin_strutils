# Returns a Strings object with the list of files under a given path.
# Unlike the native Praat command, this script returns files with their
# full paths.
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

include ../../plugin_strutils/procedures/file_list_full_path.proc
include ../../plugin_utils/procedures/check_directory.proc

form Create Strings as file list (full path)...
  word     Name fullFileList
  sentence Path
  sentence File_match *wav
  boolean  Keep_relative_path_list 0
endform

@checkDirectory(path$, "Read from...")
path$ = checkDirectory.name$

@fileListFullPath(name$, path$, file_match$, keep_relative_path_list)
