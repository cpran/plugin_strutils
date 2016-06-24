include ../../plugin_utils/procedures/utils.proc
include ../../plugin_utils/procedures/try.proc
include ../../plugin_strutils/procedures/extract_strings.proc
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

@extractStrings: "a1", 1
@is: numberOfSelected("Strings") or selected("Strings") == strings, 1,
  ... "procedure generates new strings"
Remove

selectObject: strings
@extractStrings: "", 1
@is: extractStrings.return, 25,
  ... "procedure matching empty literal string copies Strings"
Remove

selectObject: strings
@extractStrings: "", 0
@is: extractStrings.return, 0,
  ... "procedure not matching empty literal string makes empty Strings"
Remove

selectObject: strings
@extractStrings: "a", undefined
@is: extractStrings.return, 0,
  ... "procedure (literal) with undefined matching flag makes empty Strings"
Remove

selectObject: strings
@extractStrings: "a", 1
@is: extractStrings.return, 5,
  ... "procedure matching literal string"
Remove

selectObject: strings
@extractStrings: "a", 0
@is: extractStrings.return, 20,
  ... "procedure not matching literal string"
Remove

selectObject: strings
@extractStrings: "aa", 1
@is: extractStrings.return, 0,
  ... "procedure matching missing literal string makes empty Strings"
Remove

selectObject: strings
@extractStrings:       "aa", 0
@is: extractStrings.return, 25,
  ... "procedure not matching missing literal string copies Strings"
Remove

selectObject: strings
@extractStrings_regex: "", 1
@is: extractStrings.return, 25,
  ... "procedure matching empty pattern copies Strings"
Remove

selectObject: strings
@extractStrings_regex: "", 0
@is: extractStrings_regex.return, 0,
  ... "procedure not matching empty pattern makes empty Strings"
Remove

selectObject: strings
@extractStrings_regex: "", undefined
@is: extractStrings_regex.return, 0,
  ... "procedure (regex) with undefined matching flag makes empty Strings"
Remove

selectObject: strings
@extractStrings_regex: ".[13]", 1
@is: extractStrings_regex.return, 10,
  ... "procedure matching pattern"
Remove

selectObject: strings
@extractStrings_regex: ".[13]", 0
@is: extractStrings_regex.return, 15,
  ... "procedure not matching pattern"
Remove

selectObject: strings
@extractStrings_regex: "a{3}", 1
@is: extractStrings_regex.return, 0,
  ... "procedure matching missing pattern makes empty Strings"
Remove

selectObject: strings
@extractStrings_regex: "a{3}", 0
@is: extractStrings_regex.return, 25,
  ... "procedure not matching missing pattern copies Strings"
Remove

selectObject: strings
@extractStrings:       "a1", 1
Remove
selectObject: strings
@extractStrings_regex: "a1", 1
Remove

@is: extractStrings.return, extractStrings_regex.return,
  ... "literal string treated the same by both procedures"

selectObject: strings
@extractStrings:       "a{3}", 1
Remove
selectObject: strings
@extractStrings_regex: "a{3}", 1
Remove

@is: extractStrings.return, extractStrings_regex.return,
  ... "pattern treated differently by both procedures"

# Scripts

selectObject: strings
runScript: strutils$ + "extract_strings.praat", ".[123]", "matches", 0
@is: numberOfSelected("Strings") or selected("Strings") == strings, 1,
  ... "script generates new strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "", "matches", 0
@is: do("Get number of strings"), 25,
  ... "script matching empty literal string copies Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "", "does not match", 0
@is: do("Get number of strings"), 0,
  ... "script not matching empty literal string makes empty Strings"
Remove

selectObject: strings
call try
  ... runScript: "'strutils$'extract_strings.praat", "a", undefined, 0
@is: try.catch, 1,
  ... "script does not take undefined matching flag"

selectObject: strings
call try
  ... runScript: "'strutils$'extract_strings.praat", "a", 0, undefined
@is: try.catch, 1,
  ... "script does not take undefined regex flag"

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "a", "matches", 0
@is: do("Get number of strings"), 5,
  ... "script matching literal string"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "a", "does not match", 0
@is: do("Get number of strings"), 20,
  ... "script not matching literal string"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "aa", "matches", 0
@is: do("Get number of strings"), 0,
  ... "script matching missing literal string makes empty Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "aa", "does not match", 0
@is: do("Get number of strings"), 25,
  ... "script not matching missing literal string copies Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "", "matches", 1
@is: do("Get number of strings"), 25,
  ... "script matching empty pattern copies Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "", "does not match", 1
@is: do("Get number of strings"), 0,
  ... "script not matching empty pattern makes empty Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", ".[13]", "matches", 1
@is: do("Get number of strings"), 10,
  ... "script matching pattern"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", ".[13]", "does not match", 1
@is: do("Get number of strings"), 15,
  ... "script not matching pattern"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "a{3}", "matches", 1
@is: do("Get number of strings"), 0,
  ... "script matching missing pattern makes empty Strings"
Remove

selectObject: strings
runScript: strutils$ + "extract_strings.praat", "a{3}", "does not match", 1
@is: do("Get number of strings"), 25,
  ... "script not matching missing pattern copies Strings"
Remove

removeObject: strings

@ok_selection()

@done_testing()
