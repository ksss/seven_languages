#! /usr/bin/env io

"# 1" println
# recursive
fib_re := method(n,
  if(n < 2, return n)
  fib_re(n - 1) + fib_re(n - 2)
)
# loop
fib_loop := method(n,
  if(n < 3, return 1)
  tmp := list(1, 1)
  for(i, 3, n,
    tmp = list(tmp at(0) + tmp at(1), tmp at(0))
  )
  tmp at(0)
)
for(i, 1, 10,
  fib_re(i) print
  " : " print
  fib_loop(i) println
)


"\n# 2" println
Number div := Number getSlot("/")
Number / = method(num,
  if(num == 0, 0, div(num))
)
(10 / 0) println
(10 / 3) println


"\n# 3" println
array := list(
  list(1, 2, 3),
  list(4, 5, 6),
  list(7, 8, 9)
) flatten sum println


"\n# 4" println
List myAverage := method(
  self foreach(key, value,
    if(value type != "Number", Exception raise("Not a Number "))
  )
  self sum / self size
)
list(3, 5, 7, 9, 11) myAverage println
e := try(list() myAverage println)
e catch(Exception, e error println)
e := try(list(1, "a") myAverage println)
e catch(Exception, e error println)


"\n# 5" println
Matrix := Object clone
Matrix x := nil
Matrix y := nil
Matrix values := nil
Matrix dim := method(x, y,
  self x = x
  self y = y
  self values = List clone
  for(i, 0, y,
    self values push(list() setSize(x))
  )
)
Matrix set := method(x, y, value,
  if(x < 0 or self x - 1 < x or y < 0 or self y - 1 < y, Exception raise("out of size"))
  self values at(y) atPut(x, value)
)
Matrix get := method(x, y,
  if(x < 0 or self x - 1 < x or y < 0 or self y - 1 < y, Exception raise("out of size"))
  self values at(y) at(x)
)
matrix := Matrix clone
matrix dim(3, 3)
matrix set(0, 2, "this is {x:1,y:3}")
matrix get(0, 2) println


"\n# 6" println
Matrix transposed := method(
  that := Matrix clone
  that dim(self y, self x)
  for(y, 0, (self y) - 1,
    for(x, 0, (self x) - 1,
      that set(y, x, self get(x, y))
    )
  )
  that
)
matrix := Matrix clone
matrix dim(5, 3)
matrix set(3, 2, "tarnsposed ?")
matrix set(1, 1, 123)
new_matrix := matrix transposed
((new_matrix get(2, 3)) == matrix get(3, 2)) println
((new_matrix get(1, 1)) == matrix get(1, 1)) println


"\n# 7" println
matrix := Matrix clone
matrix dim(2, 3)
matrix set(0, 0, 2)
matrix set(0, 1, 4)
matrix set(0, 2, 9)
matrix set(1, 0, 6)
matrix set(1, 1, 5)
matrix set(1, 2, 0)
string := ""
for(x, 0, matrix x - 1,
  list := List clone
  for(y, 0, matrix y - 1,
    list push(matrix get(x, y))
  )
  string = string .. list join(" ") .. "\n"
)
file := File clone open("./tmp")
file write(string)
file close

file := File clone openForReading("./tmp")
while(line := file readLine,
  line println
)


"\n# 8" println
"Game start" println
"Guess a 1..100 Secret Number in 10 times" println
answer := (Random value(99) + 1) floor
diff := 0
count := 1
while(input := File standardInput readLine asNumber,
  if(input == answer,
    "clear" println
    break
  )
  if(1 < count,
    if((input - answer) abs < diff, ("near / " .. count .. " times") println)
    if((input - answer) abs > diff, ("far / " .. count .. " times") println)
    if((input - answer) abs == diff, ("even / " .. count .. " times") println)
  )
  if(count == 10,
    ("game over answer is " .. answer) println
    break
  )
  diff = (input - answer) abs
  count = count + 1
)
