include ../procedures/extract_strings.proc
include ../../plugin_testsimple/procedures/test_simple.proc

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

@extractStrings: ".[123]"
if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "procedure does not generate new strings"
endif
part = selected("Strings")

n = Get number of strings
@ok_formula: "n = 3 * length(letters$)",
  ... "extracted existing strings with regex"

removeObject: part

selectObject: strings
@extractStrings: "aaa"
part = selected("Strings")
n = Get number of strings

@ok: !n,
  ... "extracting non existing set makes empty strings"

removeObject: part

# Scripts

selectObject: strings
runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/extract_strings.praat", ".[123]"
if !numberOfSelected("Strings") or selected("Strings") = strings
  @bail_out: "script does not generate new strings"
endif
part = selected("Strings")

n = Get number of strings
@ok_formula: "n = 3 * length(letters$)",
  ... "extracted existing strings with regex"

removeObject: part

selectObject: strings
runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/extract_strings.praat", "aaa"
part = selected("Strings")
n = Get number of strings

@ok: !n,
  ... "extracting non existing set makes empty strings"

removeObject: part

removeObject: strings

@done_testing()
