#! /usr/bin/env io

"# 1" println
Builder := Object clone do(
  depth := 0
  forward := method(
    depth repeat(write("  "))
    writeln("<", call message name, ">")
    call message arguments foreach(arg,
      depth = depth + 1
      content := self doMessage(arg)
      if(content type == "Sequence",
        depth repeat(write("  "))
        writeln(content)
      )
      depth = depth - 1
    )
    depth repeat(write("  "))
    writeln("</", call message name, ">")
  )
)

Builder ul(
  li("foo")
  ul(
    li(
      p("baz")
      a()
      ul(
        li("100")
        p("hoge", span("aaa"), span("bbb"))
      )
      p("fuge")
    )
  )
)


"# 2" println
squareBrackets := method(call message arguments)

sqlist := [1,2,3]
sqlist type println
sqlist asString println


"# 3" println
OperatorTable addAssignOperator(":", "atPutValue")
Map atPutValue := method(
  self atPut(call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""), call evalArgAt(1))
)
curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  r
)

Builder := Object clone do(
  depth := 0
  forward := method(
    depth repeat(write("  "))
    args := call message arguments
    if (args first name == "curlyBrackets",
      attr_string := doString(args removeFirst code) map(key, value,
        key .. "=\"" .. value .. "\""
      ) join(" ")
      writeln("<", call message name, " ", attr_string, ">")
    ,
      writeln("<", call message name, ">")
    )
    args foreach(arg,
      depth = depth + 1
      content := self doMessage(arg)
      if(content type == "Sequence",
        depth repeat(write("  "))
        writeln(content)
      )
      depth = depth - 1
    )
    depth repeat(write("  "))
    writeln("</", call message name, ">")
  )
)

Builder html(
  head(title("Io in 3 day"))
  body(
    book({"autor":"Tate"}, "Seven Lunguages in Seven Weeks")
    p({"class":"first"},"foo", span({"style":"color:red"}, "bar"), "baz")
  )
)
