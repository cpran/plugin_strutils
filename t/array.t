include ../../plugin_tap/procedures/more.proc
include ../../plugin_strutils/procedures/array.proc
include ../../plugin_utils/procedures/utils.proc

@plan: 29

@array()
@is: numberOfSelected("Strings"), 1,
  ... "array Strings created"
array = array.id

@is: do("Get number of strings"), 0,
  ... "array is empty"

@push: 4

@is: do("Get number of strings"), 1,
  ... "can push number"
@is: number(Object_'array'$[1]), 4,
  ... "pushed number is correct"

@push$: "3"
@is: do("Get number of strings"), 2,
  ... "can push string"
@is$: Object_'array'$[2], "3",
  ... "pushed string is correct"

@pop()

@is: do("Get number of strings"), 1,
  ... "can pop element"

@is: pop.return, 3,
  ... "popped number is correct"

@is$: pop.return$, "3",
  ... "popped string is correct"

@shift()

@is: do("Get number of strings"), 0,
  ... "can shift element"

@is: shift.return, 4,
  ... "shifted number is correct"

@is$: shift.return$, "4",
  ... "shifted string is correct"

@unshift$: "a"

@is: do("Get number of strings"), 1,
  ... "can unshift string"

@is$: Object_'array'$[1], "a",
  ... "unshifted string is correct"

@unshift: 2

@is: do("Get number of strings"), 2,
  ... "can unshift number"

@is$: Object_'array'$[1], "2",
  ... "unshifted number is correct"

removeObject: array

@split: " ", "correct horse battery staple"

@is_true: variableExists("split.id"),
  ... "split creates an object"

selectObject: split.id

@is: do("Get number of strings"), 4,
  ... "split string into correct number of parts"

@join: "|"

@is$: join.return$, "correct|horse|battery|staple",
  ... "join strings in array"

removeObject: split.id

@array()
@join: " "

@is$: join.return$, "",
  ... "joined empty array is empty string"

removeObject: array.id

items = 10

@array()
backup = array.id
for i to items
  @push$: string$(i)
endfor
x = do("Get number of strings") / 4 div 1

@restore()
@slice: x, x + x
@is: do("Get number of strings"), x + 1, "slice with positive range"
selectObject: list
@is: do("Get number of strings"), items, "slice does not modify original"
removeObject: slice.return

@restore()
@excise: x, x + x
@is: do("Get number of strings"), x + 1, "excise with positive range"
selectObject: list
@is: do("Get number of strings"), items - (x + 1), "excise modifies original"
removeObject: slice.return

@restore()
@slice: x, x
@is: do("Get number of strings"), 1, "slice with no range"
removeObject: slice.return

@restore()
@slice: x, x - 1
@is: do("Get number of strings"), 0, "slice with negative range"
removeObject: slice.return

@restore()
@slice: x, -1
@is: do("Get number of strings"), items + 1 - x, "slice to negative index"
removeObject: slice.return

@restore()
@slice: -(x + x), -1
@is: do("Get number of strings"), x + x, "slice with two negative indices"
removeObject: slice.return

removeObject: list, backup

@ok_selection()

@done_testing()

procedure restore
  nocheck removeObject: list
  selectObject: backup
  list = Copy: selected$("Strings")
endproc
