include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_testsimple/procedures/test_simple.proc

preferencesDirectory$ = replace_regex$(preferencesDirectory$, "(con)?(\.(EXE|exe))?$", "", 0)
preferencesDirectory$ = replace_regex$(preferencesDirectory$, "\\", "/", 0)
if right$(preferencesDirectory$) != "/"
  preferencesDirectory$ = preferencesDirectory$ + "/"
endif

@no_plan()

# Scripts

runScript: preferencesDirectory$ +
  ... "plugin_strutils/scripts/recursive_directory_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", 0, "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

@ok_formula: "numberOfSelected(""Strings"") == 1",
  ... "returns only one Strings object"

strings = selected("Strings")
n = Get number of strings

@ok: n,
  ... "does not return empty Strings"

@findInStrings: preferencesDirectory$, 0
@ok: findInStrings.return,
  ... "strings from script contains path"

@findInStrings: preferencesDirectory$ + "plugin_strutils/t", 0
@ok: findInStrings.return,
  ... "script finds sub-dir two levels removed"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

runScript: preferencesDirectory$ +
  ... "plugin_strutils/scripts/recursive_directory_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", 1, "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

@ok_formula: "numberOfSelected(""Strings"") == 1",
  ... "returns only one Strings object"

strings = selected("Strings")
n = Get number of strings

@ok: n,
  ... "does not return empty Strings"

@findInStrings: preferencesDirectory$ + "plugin_strutils/t", 0
@ok: !findInStrings.return,
  ... "script does not find sub-dir two levels removed with max_depth=1"

removeObject: strings

@done_testing()
