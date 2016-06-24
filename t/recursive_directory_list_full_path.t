include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_tap/procedures/more.proc

@no_plan()

# Scripts

strutils$ = preferencesDirectory$ + "/plugin_strutils/scripts/"
runScript: strutils$ + "recursive_directory_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", 0, "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

@is: numberOfSelected("Strings"), 1,
  ... "returns only one Strings object"

strings = selected("Strings")
n = Get number of strings

@isnt: n, 0,
  ... "does not return empty Strings"

@findInStrings: preferencesDirectory$, 1
@isnt: findInStrings.return, 0,
  ... "strings from script contains path"

@findInStrings: preferencesDirectory$ + "/plugin_strutils/t", 1
@isnt: findInStrings.return, 0,
  ... "script finds sub-dir two levels removed"

@replaceStrings: preferencesDirectory$, "", 0
@is: replaceStrings.return, n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

runScript: strutils$ + "recursive_directory_list_full_path.praat",
  ... "full_path", preferencesDirectory$, "*", 1, "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

@is: numberOfSelected("Strings"), 1,
  ... "returns only one Strings object"

strings = selected("Strings")
n = Get number of strings

@isnt: n, 0,
  ... "does not return empty Strings"

@findInStrings: preferencesDirectory$ + "/plugin_strutils/t", 1
@is: findInStrings.return, 0,
  ... "script does not find sub-dir two levels removed with max_depth=1"

removeObject: strings

@done_testing()
