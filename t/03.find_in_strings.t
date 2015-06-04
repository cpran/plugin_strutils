include ../procedures/find_in_strings.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@no_plan()

runScript: preferencesDirectory$ -"con" +
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

@findInStrings: "^e", 0
@ok: !findInStrings.return,
  ... "failed to find non existing string literal"

@findInStrings: "e1", 0
@ok_formula: "findInStrings.return = length(letters$) + 1",
  ... "found existing string literal"

@findInStrings: "a{3}", 1
@ok: !findInStrings.return,
  ... "failed to find non existing regex"

@findInStrings: "^e", 1
@ok_formula: "findInStrings.return = length(letters$) + 1",
  ... "found existing regex"

removeObject: strings

@done_testing()
