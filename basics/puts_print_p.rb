puts, print and p — the three ways to show output, and when to use each

Lesson 1: puts — "print line", the everyday default

  puts "hello"
  puts "world"

Prints each argument on its own line, then adds a newline at the end:

  hello
  world

puts converts everything to a string with to_s before printing. Numbers, symbols,
booleans all work:

  puts 42          # 42
  puts :hi         # hi
  puts true        # true

Lesson 2: print — puts without the newline

  print "a"
  print "b"

Prints ab on ONE line. Use print when you're building a line piece by piece:

  print "total: "
  puts 100

Output: total: 100  (one line, because print didn't add a newline)

The trap: print doesn't add newlines — if you forget, everything runs together
and the output looks broken.

Lesson 3: p — the debugger's friend

  p "hi"     # "hi"
  p "say \"hi\""   # "say \"hi\""

p is puts with extra eyes: it prints the object's inspect version instead of to_s.
Two differences:

  puts "hi"    # hi      — human-friendly, quotes hidden
  p "hi"       # "hi"    — shows you exactly what the data IS (quotes, escapes)

That's why p is great while debugging: it shows reality. And it adds a newline
automatically (like puts).

Lesson 4: The return values — a sneaky difference

  result = puts "x"    # => nil    (puts returns nil)
  result = print "x"   # => nil    (print returns nil)
  result = p "x"       # => "x"    (p RETURNS the object itself)

Why this matters: p lets you chain/debug in one step:

  p 1 + 1     # prints 2 AND returns 2

Lesson 5: Arrays behave differently

  puts ["a", "b"]      # a
                       # b        — one element per line

  print ["a", "b"]     # ["a", "b"]   — prints the array as one blob

  p ["a", "b"]         # ["a", "b"]   — inspect version, with quotes

Lesson 6: nil prints as a blank line with puts

  puts nil             # prints nothing but the newline
  p nil                # nil        — p shows you it was really nil

Lesson 7: The traps, collected

Trap A — puts vs print on newlines: forget a \n after print and output glues together.

Trap B — p is NOT "puts for strings". It uses inspect, so it's for debugging.
It will happily print quotes and backslashes that puts would hide.

Trap C — don't use puts inside code that must return a value. puts always returns
nil, so `return puts "x"` returns nil, not "x".

Bonus: pp (pretty print) — for big nested data, use pp instead of p:

  require "pp"
  pp [{name: "Fatma", age: 30}]    # prints in readable, indented form

The whole thing in one sentence
puts = human-friendly line with newline; print = same but no newline;
p = raw inspect version for debugging (and it returns the object) — pick puts
for real output, p when you're checking what the data actually is.
