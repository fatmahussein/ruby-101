Comments in Ruby — notes to your future self (and to Ruby, which ignores them)

Lesson 1: The single-line comment — #

A comment is any text after a #. Ruby reads the line, ignores the # and everything
after it, and moves on. Comments are for humans; Ruby never executes them.

  # this whole line is a comment
  name = "Fatma"   # this part is a comment too

puts name          # Ruby only runs the code, never the notes

Lesson 2: Where comments go

Before a tricky line — explain WHY, not what (the code already shows what):

  # count starts at 1 because the loop below skips the header row
  count = 1

At the end of a line — a quick label:

  total += price * quantity   # total in shillings

Standalone — a divider or a note between sections:

  # ---- setup ----
  # ---- main logic ----

The trap: do NOT use comments to explain the obvious. This adds noise, not help:

  x = x + 1   # increments x      <- says what the code says. skip it.

Lesson 3: Ruby has no "block comment" in the normal sense

Other languages have /* ... */ for multi-line comments. Ruby doesn't. You simply
put a # on each line:

  # line one
  # line two
  # line three

Lesson 4: The =begin ... =end block comment — with a strict rule

Ruby DOES have one block-comment form, but it's fussy. Everything between
=begin and =end is ignored:

  =begin
  This whole block is a comment.
  Great for temporarily turning off a section while debugging.
  =end
  

The strict rule: both =begin and =end must sit at the START of the line
(column zero — no indentation). Indent either one and Ruby treats the =
as regular code, which is a syntax error:

  class Example
    =begin      # trap! indented =begin → SyntaxError, NOT a comment
    =end
=end
Lesson 5: The shebang line

If your file is executable (./my_script.rb), the very first line can be:

  #!/usr/bin/env ruby

Ruby treats it as a comment. It tells the shell which interpreter to use.


Lesson 6: Magic comments — the one comment that DOES something

A few comments are read by Ruby before the program starts. The one you'll see
most is the frozen-string-literal marker, always at the top of the file:

  # frozen_string_literal: true

It tells Ruby to treat every string literal as frozen (immutable) — a speed
and safety optimization. It's a comment, but not an inert one.

Lesson 7: The traps

Trap A — a # inside a string is NOT a comment. It's part of the data:

  puts "3 # 4"      # prints: 3 # 4   (the # here is text, not a comment)

Trap B — indented =begin or =end causes a SyntaxError. They must start at
column zero. This is why most Rubyists avoid =begin entirely and just use #.

Trap C — comments can't be nested, and =begin ends at the FIRST =end.
Putting =begin inside =begin just ends the block early.

The whole thing in one sentence
A # comment hides the rest of its line from Ruby; =begin/=end hide a whole
block (only at column zero); everything else — shebang, magic comments,
trailing notes — is just variations on "text Ruby ignores."
