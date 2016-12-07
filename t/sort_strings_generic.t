include ../../plugin_utils/procedures/utils.proc
include ../../plugin_tap/procedures/more.proc

@plan: 5

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/create_empty_strings.praat", "empty"
strings = selected("Strings")

letters$ = "aeiou"
for x to length(letters$)
  for y from 9 to 10
    selectObject: strings
    n = Get number of strings
    Insert string: n+1, string$(y) + mid$(letters$, x, 1)
  endfor
endfor
for x to length(letters$)
  selectObject: strings
  n = Get number of strings
  Insert string: n+1, mid$(letters$, x, 1)
  Insert string: n+1, replace_regex$(mid$(letters$, x, 1), "([a-z]+)", "\U\1", 0)
endfor
n = Get number of strings

runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/sort_strings_generic.praat", "yes", "yes"
a$ = Get string: 2
b$ = Get string: 15

@ok: a$ == "9e" and b$ == "U",
  ... "sort numeric first and case sensitive"

runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/sort_strings_generic.praat", "yes", "no"

a$ = Get string: 2
b$ = Get string: 15

@ok: a$ == "9e" and (b$ == "I" or b$ == "i"),
  ... "sort numeric first and case insensitive"

runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/sort_strings_generic.praat", "no", "yes"

a$ = Get string: 2
b$ = Get string: 15

@ok: a$ == "E" and b$ == "9u",
  ... "sort numeric last and case sensitive"

runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/sort_strings_generic.praat", "no", "no"

a$ = Get string: 2
b$ = Get string: 15

@ok: (a$ == "a" or a$ == "A") and b$ == "9u",
  ... "sort numeric last and case insensitive"

removeObject: strings

@ok_selection()

@done_testing()
