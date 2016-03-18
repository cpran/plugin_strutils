include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_testsimple/procedures/test_simple.proc

preferencesDirectory$ = replace_regex$(preferencesDirectory$, "(con)?(\.(EXE|exe))?$", "", 0)
preferencesDirectory$ = replace_regex$(preferencesDirectory$, "\\", "/", 0)
if right$(preferencesDirectory$) != "/"
  preferencesDirectory$ = preferencesDirectory$ + "/"
endif

@no_plan()

total_files = 10
for i to total_files
  @mktempfile: "strutils_", "txt"
  tmp$[i] = mktempfile.name$
endfor

# Scripts

strutils$ = preferencesDirectory$ + "plugin_strutils/"

runScript: strutils$ + "scripts/recursive_file_list_full_path.praat",
  ... "full_path", strutils$, "*", 0, "no"

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

@findInStrings: strutils$ + "t/09.recursive_file_list_full_path.t", 0
@ok: findInStrings.return,
  ... "script finds file two levels removed"

@replaceStrings: preferencesDirectory$, "", 0
@ok: replaceStrings.return = n,
  ... "all strings from script contain path"

removeObject: selected("Strings"), strings

runScript: strutils$ + "scripts/recursive_file_list_full_path.praat",
  ... "full_path", strutils$, "*", 1, "no"

if !numberOfSelected("Strings")
  @bail_out: "script does not generate strings"
endif

@ok_formula: "numberOfSelected(""Strings"") == 1",
  ... "returns only one Strings object"

strings = selected("Strings")
n = Get number of strings

@ok: n,
  ... "does not return empty Strings"

appendInfoLine: strutils$ + "t/09.recursive_file_list_full_path.t"

@findInStrings: strutils$ + "t/09.recursive_file_list_full_path.t", 0
@ok: !findInStrings.return,
  ... "script does not find file two levels removed with max_depth=1"

removeObject: strings

for i to total_files
  deleteFile: tmp$[i]
endfor

@done_testing()
