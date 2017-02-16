include ../../plugin_utils/procedures/utils.proc
include ../../plugin_strutils/procedures/strings_from_string.proc
include ../../plugin_tap/procedures/more.proc

@plan: 5

@stringsFromString: "blank", ""
@is_true: numberOfSelected("Strings"), "Created a Strings object"
@is: do("Get number of strings"), 0, "Strings is empty with empty string"
@is$: selected$("Strings"), "blank", "Can specify name"
Remove

@stringsFromString: "multi", "hello'newline$''newline$'world'newline$'"
@is_true: numberOfSelected("Strings"), "Created a Strings object"
@is: do("Get number of strings"), 3, "One string per line, including blanks"
Remove

@ok_selection()

@done_testing()
