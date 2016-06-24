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

include ../../plugin_strutils/procedures/replace_strings.proc

form Replace strings...
  sentence Find
  sentence Replace
  integer How_many_replacements 0 (= all)
  boolean Use_regular_expressions 1
endform

if use_regular_expressions
  @replaceStrings_regex: find$, replace$, how_many_replacements
else
  @replaceStrings: find$, replace$, how_many_replacements
endif
