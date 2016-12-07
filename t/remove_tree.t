include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/find_in_strings.proc
include ../../plugin_strutils/procedures/replace_strings.proc
include ../../plugin_strutils/procedures/directory_list_full_path.proc
include ../../plugin_tap/procedures/more.proc

@plan: 1
files = 5

@mktemp: "remove_XXXXXX"
path$ = mktemp.return$

for i to files
  writeFileLine: path$ + string$(i), ""
endfor

createDirectory: path$ + "subdir"
for i to files
  writeFileLine: path$ + "subdir/" + string$(i), ""
endfor

runScript: preferencesDirectory$ + "/plugin_strutils/scripts/remove_tree.praat", path$, "*"

@is_false: fileReadable(path$), "Deleted"

@ok_selection()

@done_testing()
