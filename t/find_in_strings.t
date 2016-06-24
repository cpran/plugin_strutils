include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_tap/procedures/more.proc

@normalPrefDir()

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

@findInStrings: "^e", 1
@ok: !findInStrings.return,
  ... "procedure failed to find non existing string literal"

@findInStrings: "e1", 1
@ok: findInStrings.return = length(letters$) + 1,
  ... "procedure found existing string literal"

@findInStrings_regex: "a{3}", 1
@ok: !findInStrings_regex.return,
  ... "procedure failed to find non existing regex"

@findInStrings_regex: "^e", 1
@ok: findInStrings_regex.return = length(letters$) + 1,
  ... "procedure found existing regex"

runScript: strutils$ + "find_in_strings.praat", "^e", "matches", 0
@is: number(extractLine$(info$(), "")), 0,
  ... "script failed to find non existing string literal"

runScript: strutils$ + "find_in_strings.praat", "e1", "matches", 0
@is: number(extractLine$(info$(), "")), length(letters$) + 1,
  ... "script found existing string literal"

runScript: strutils$ + "find_in_strings.praat", "a{3}", "matches", 1
@is: number(extractLine$(info$(), "")), 0,
  ... "script failed to find non existing regex"

runScript: strutils$ + "find_in_strings.praat", "^e", "matches", 1
@is: number(extractLine$(info$(), "")), length(letters$) + 1,
  ... "script found existing regex"

removeObject: strings

@done_testing()
