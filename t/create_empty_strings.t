include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/create_empty_strings.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@normalPrefDir()

@no_plan()

@createEmptyStrings: "empty"
strings = selected("Strings")
@ok_formula: "numberOfSelected(""Strings"") = 1",
  ... "procedure creates strings object"
total_strings = Get number of strings
@ok: !total_strings,
  ... "strings from procedure is empty"

removeObject: strings

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/create_empty_strings.praat", "empty"
strings = selected("Strings")
@ok_formula: "numberOfSelected(""Strings"") = 1",
  ... "script creates strings object"
total_strings = Get number of strings
@ok: !total_strings,
  ... "strings from script is empty"

removeObject: strings

@done_testing()
