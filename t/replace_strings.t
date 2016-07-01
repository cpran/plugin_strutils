include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_tap/procedures/more.proc

@no_plan()

strutils$ = preferencesDirectory$ + "/plugin_strutils/scripts/"
runScript: strutils$ + "create_empty_strings.praat", "empty"
strings = selected("Strings")

letters$ = "aeiou"
for x to length(letters$)
  for y to length(letters$)
    selectObject: strings
    n = Get number of strings
    Insert string: n+1, mid$(letters$, x, 1) + string$(y)
  endfor
endfor

# Procedures

selectObject: strings
@findInStrings_regex: "^[" + letters$ + "][0-9]", 1
before = findInStrings_regex.return

@replaceStrings_regex: "^([" + letters$ + "])", "\1\1", 0
if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "procedure does not generate new strings"
endif
@findInStrings_regex: "^[" + letters$ + "][0-9]", 1
after = findInStrings_regex.return

@ok: before != after,
  ... "procedure made changes to strings"

@ok: !after,
  ... "procedure replaced all strings"

removeObject: selected("Strings")

runScript: strutils$ + "create_empty_strings.praat", "empty"
empty = selected("Strings")

@replaceStrings_regex: "^([" + letters$ + "])", "\1\1", 0
@ok: selected("Strings") and selected("Strings") != empty,
  ... "works on empty strings"

removeObject: selected("Strings"), empty

# Scripts

selectObject: strings
@findInStrings_regex: "^[" + letters$ + "][0-9]", 1
before = findInStrings_regex.return

runScript: strutils$ + "replace_strings.praat",
  ... "^([" + letters$ + "])", "\1\1", 0, 1

if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "procedure does not generate new strings"
endif

@findInStrings_regex: "^[" + letters$ + "][0-9]", 1
after = findInStrings_regex.return

@ok: before != after,
  ... "script made changes to strings"

@ok: !after,
  ... "script replaced all strings"

removeObject: selected("Strings")

runScript: strutils$ + "create_empty_strings.praat", "empty"
empty = selected("Strings")

runScript: strutils$ + "replace_strings.praat",
  ... "^([" + letters$ + "])", "\1\1", 0, 1

@ok: selected("Strings") and selected("Strings") != empty,
  ... "works on empty strings"

removeObject: selected("Strings"), empty

removeObject: strings

@ok_selection()

@done_testing()
