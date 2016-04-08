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

include ../../plugin_strutils/procedures/find_in_strings.proc

#! ~~~ params
#! in:
#!   Search: >
#!     (sentence) A query for matching
#!   Path: >
#!     (boolean) If true (the default), the search string will be interpreted
#!     as a regular expression pattern. Otherwise, it will be treated as a
#!     literal string. In this case, any occurrence in any part of the string
#!     will result in a match.
#! selection:
#!   in:
#!     strings: 1
#! ~~~
#!
#! Run on a single Strings object, this script performs a search for the
#! specified string (interpreted either as a literal or as a regular expression
#! pattern) and prints the index of the first found string to the Info window.
#! If the string was not found, `0` is printed instead.
#!
form Find in Strings...
  sentence Search .*
  boolean Use_regex 1
endform

@findInStrings(search$, use_regex)

writeInfoLine: findInStrings.return
