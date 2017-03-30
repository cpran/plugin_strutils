include ../../plugin_strutils/procedures/remove_duplicate_strings.proc
include ../../plugin_tap/procedures/more.proc

@plan: 6

list =  Create Strings as tokens: "zoo foo baz bar foo bar"

original = Get number of strings

@removeDuplicateStrings()

@is_true: numberOfSelected("Strings"),
  ... "has a Strings selected"

@isnt: removeDuplicateStrings.id, list,
  ... "created new Strings object"

sorted = Get number of strings

@is: original, sorted + 2,
  ... "removed duplicate strings"

@is$: Object_'removeDuplicateStrings.id'$[sorted], "bar",
  ... "maintained order of stisngs"

Remove
removeObject: list

empty = Create Strings as characters: ""
@removeDuplicateStrings()
@is: do("Get number of strings"), 0,
  ... "removing duplicates from empty strings is empty strings"

Remove
removeObject: empty

@ok_selection()

@done_testing()
