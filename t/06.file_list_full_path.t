include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_strutils/procedures/file_list_full_path.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@normalPrefDir()

@no_plan()

# Procedures

@fileListFullPath: "full_path", preferencesDirectory$, "*", 0

if !numberOfSelected("Strings")
  @bail_out: "procedure does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferencesDirectory$, 0
@ok: findInStrings.return,
  ... "strings from procedure contains path"

Save as text file: "test_strings_procedure.Strings"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from procedure contain path"

removeObject: selected("Strings"), strings

# Scripts

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/file_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferencesDirectory$, 0
@ok: findInStrings.return,
  ... "strings from script contains path"

Save as text file: "test_strings_script.Strings"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

@done_testing()
