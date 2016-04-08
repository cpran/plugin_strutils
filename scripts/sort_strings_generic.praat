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

include ../../plugin_utils/procedures/require.proc
@require("5.3.44")

#! ~~~ params
#! in:
#!   Numeric first: >
#!     (boolean) If true, numerics appear above alphabetics. otherwise
#!     they appear last. Defaults to true.
#!   Case sensitive: >
#!     (boolean) If true, uppercase and lowercase letters are treated as
#!     different entities, with uppercase letter coming before. Defaults
#!     to true.
#! selection:
#!   in:
#!     strings: ~
#! ~~~
#!
#! Perform a generic sort on a Strings object.
#!
#! The default `Sort` command for Strings sorts things ASCII-betically, such
#! that uppercase letters come before lowercase, and numbers are ordered as
#! if they were words. Since Strings often represent lists of files or
#! directories, this is often not what one wants, specially in the case of
#! names starting with numbers.
#!
#! Ordered ASCII-betically, a list like
#!
#!     20, a10, Abc, 10, 1, a2, abc, abdce, 2, Ab, a1
#!
#! would become
#!
#!     1, 10, 2, 20, Ab, Abc, a1, a10, a2, abc, abdce
#!
#! A generic sort treats numbers like numbers, and strings like strings, such
#! that the previous list would be ordered in a much more intuitive way:
#!
#!     1, 2, 10, 20, Ab, Abc, a1, a2, a10, abc, abdce
#!
#! The specifics of the ordering can be adjusted with the two boolean parameters.
#! The first one sets the relative position of numbers (or strings that look
#! like numbers) as a group, while the second one allows one to do a case-
#! insensitive sort. As an example, with both values set to false (the
#! non-default value), the above list would become
#!
#!     a1, a2, a10, Ab, abc, Abc, abdce, 1, 2, 10, 20
#!
#! with the relative position of the fifth and sixth terms being unspecified.
#!
form Sort strings (generic)...
  boolean Numeric_first yes
  boolean Case_sensitive yes
endform

n = numberOfSelected("Strings")
for i to n
  strings[i] = selected("Strings", i)
endfor

for i to n
  # stopwatch

  selectObject(strings[i])
  nstrings = Get number of strings

  # Create an empty table
  cols$ = "num str"
  if !case_sensitive
    cols$ = cols$ + " lc"
  endif
  table = Create Table with column names: "nums", nstrings, cols$

  # Populate the table with the strings or their number versions where possible
  for row to nstrings
    selectObject(strings[i])
    s$ = Get string: row
    s = number(s$)

    selectObject(table)
    Set string value: row, "str", s$
    if !case_sensitive
      Set string value: row, "lc", replace_regex$(s$, "(.*)", "\L\1", 0)
    endif
    # This prevents strings like "10e" from generating undefined values
    num$ = replace_regex$(s$, "^(\d*).*", "\1", 0)
    num = if num$ = "" then undefined else number(num$) fi
    Set numeric value: row, "num", num
  endfor

  sort$ = "num " + if case_sensitive then "str" else "lc" fi
  Sort rows: sort$

  # Invert order for non-numeric strings first
  if !numeric_first
    selectObject(table)
    nantable = nowarn Extract rows where column (text): "num",
      ... "is equal to", "--undefined--"
    selectObject(table)
    numtable = nowarn Extract rows where column (text): "num",
      ... "is not equal to", "--undefined--"
    removeObject(table)
    selectObject(nantable, numtable)
    table = Append
    removeObject(nantable, numtable)
  endif

  # Replace the original strings with the sorted list
  selectObject(table)
  for row to nstrings
    selectObject(table)
    s$ = Get value: row, "str"
    selectObject(strings[i])
    Set string: row, s$
  endfor

  # Clean-up
  removeObject(table)

  # selectObject(strings[i])
  # name$ = selected$("Strings")
  # time = stopwatch
  # appendInfoLine("Sorted ", name$ , " in ", time)
endfor

# Restore selection
nocheck selectObject: undefined
for i to n
  plusObject(strings[i])
endfor
