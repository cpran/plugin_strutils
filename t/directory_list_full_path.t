include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_strutils/procedures/directory_list_full_path.proc
include ../../plugin_tap/procedures/more.proc

@plan: 5

# Procedures

@directoryListFullPath: "full_path", preferencesDirectory$, "*", 0

if !numberOfSelected("Strings")
  @bail_out: "procedure does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferencesDirectory$, 1
@ok: findInStrings.return,
  ... "strings from procedure contains path"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from procedure contain path"

removeObject: selected("Strings"), strings

# Scripts

runScript: preferencesDirectory$ +
  ... "/plugin_strutils/scripts/directory_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

strings = selected("Strings")
n = Get number of strings

@findInStrings: preferencesDirectory$, 1
@ok: findInStrings.return,
  ... "strings from script contains path"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

@ok_selection()

@done_testing()
