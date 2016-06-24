include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_tap/procedures/simple.proc

@no_plan()

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/create_empty_strings.praat", "empty"
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
@findInStrings: "^[" + letters$ + "][0-9]", 1
before = findInStrings.return

@replaceStrings: "^([" + letters$ + "])", "\1\1", 1
if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "procedure does not generate new strings"
endif
@findInStrings: "^[" + letters$ + "][0-9]", 1
after = findInStrings.return

@ok: before != after,
  ... "procedure made changes to strings"
@ok: !after,
  ... "procedure replaced all strings"

removeObject: selected("Strings")

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/create_empty_strings.praat",
  ... "empty"
empty = selected("Strings")

@replaceStrings: "^([" + letters$ + "])", "\1\1", 1
@ok_formula: "selected(""Strings"") and " +
  ...        "selected(""Strings"") != empty",
  ... "works on empty strings"

removeObject: selected("Strings"), empty

# Scripts

selectObject: strings
@findInStrings: "^[" + letters$ + "][0-9]", 1
before = findInStrings.return

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/replace_strings.praat",
  ... "^([" + letters$ + "])", "\1\1", 1
if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "procedure does not generate new strings"
endif

@findInStrings: "^[" + letters$ + "][0-9]", 1
after = findInStrings.return

@ok: before != after,
  ... "script made changes to strings"
@ok: !after,
  ... "script replaced all strings"

removeObject: selected("Strings")

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/create_empty_strings.praat",
  ... "empty"
empty = selected("Strings")

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/replace_strings.praat",
  ... "^([" + letters$ + "])", "\1\1", 1
@ok_formula: "selected(""Strings"") and " +
  ...        "selected(""Strings"") != empty",
  ... "works on empty strings"

removeObject: selected("Strings"), empty

removeObject: strings

@done_testing()
