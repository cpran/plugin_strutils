# Creates a Strings object which contains a subset of the strings
# of an original Strings object. Matching of strings is done through
# a regular expression.
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
# Copyright 2014-2016 Jose Joaquin Atria

include ../../plugin_strutils/procedures/extract_strings.proc

#! ~~~ params
#! in:
#!   Search: >
#!     (sentence) A string to search for
#!   Extract where string: >
#!     (option) Whether the extracted strings should be those that match
#!     the specified string, or those that don't match. Valid values are
#!     "matches" for positive matching, and "does not match" for negative.
#!   Use regex: >
#!     (boolean) Whether matching should interpret the search string as a
#!     literal or as a regular expression pattern.
#! selection:
#!   in:
#!     strings: 1
#!   out:
#!     strings: 1
#! ~~~
#!
#! Creates a Strings object which contains a subset of the strings
#! of an original Strings object. The newly created object is selected
#! after execution of this script.
#!
form Extract strings...
  sentence Search .*
  optionmenu Extract_where_string 1
    option matches
    option does not match
  boolean Use_regex 1
endform

matches = if extract_where_string$ == "matches" then 1 else 0 fi

if use_regex
  @extractStrings_regex: search$, matches
else
  @extractStrings:       search$, matches
endif
