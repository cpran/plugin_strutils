include ../procedures/find_in_strings.proc
include ../procedures/replace_strings.proc
include ../procedures/file_list_full_path.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@no_plan()

preferences_directory$ = replace_regex$(preferencesDirectory$ - "con", "\\", "/", 0)
# Procedures

@fileListFullPath: "full_path", preferences_directory$, "*", 0

if !numberOfSelected("Strings")
  @bail_out: "procedure does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferences_directory$, 0
@ok: findInStrings.return,
  ... "strings from procedure contains path"

@replaceStrings: preferences_directory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from procedure contain path"

removeObject: selected("Strings"), strings

# Scripts

runScript: preferences_directory$ +
  ... "/plugin_strutils/scripts/file_list_full_path.praat",
  ... "full_path", preferences_directory$, "*", "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferences_directory$, 0
@ok: findInStrings.return,
  ... "strings from script contains path"

@replaceStrings: preferences_directory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

@done_testing()
