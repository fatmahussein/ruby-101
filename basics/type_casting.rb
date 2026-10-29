Type casting in Ruby — converting one kind of value into another

Lesson 1: The to_ family — convert TO a type

Ruby objects can usually convert themselves with to_* methods:

  "42".to_i          # => 42          string → integer
  3.to_f             # => 3.0         integer → float
  3.14.to_s          # => "3.14"      number → string
  :hi.to_s           # => "hi"        symbol → string
  "5".to_sym         # => :5          string → symbol
  (1..3).to_a        # => [1, 2, 3]   range → array
  ({a: 1}).to_h      # => {a: 1}      (already a hash)

Lesson 2: Two styles of conversion — lenient and strict

Ruby has TWO ways to turn a string into a number. They behave differently:

  "12abc".to_i       # => 12    — lenient: reads what it can, IGNORES the rest
  Integer("12abc")   # raises ArgumentError — strict: the whole thing must be a number

Lenient (to_i / to_f) — silently stops at the first junk character:
  "12abc".to_i       # => 12
  "3.99".to_i        # => 3       (stops at the dot)
  "abc".to_i         # => 0       (no digits at all → 0)
  "3.14abc".to_f     # => 3.14

Strict (Integer() / Float()) — raises unless the ENTIRE input is a valid number:
  Integer("42")      # => 42
  Integer("12abc")   # ArgumentError
  Float("3.14")      # => 3.14
  Float("abc")       # ArgumentError

Rule of thumb: use to_i for sloppy real-world input (form fields), use
Integer() when you NEED the input to be a clean number and want errors otherwise.

Lesson 3: to_i truncates — it does NOT round

  3.99.to_i          # => 3    — decimal part is chopped off
  3.99.round         # => 4    — use round if you want rounding
  (-2.5).to_i        # => -2   — truncates toward zero

Lesson 4: nil converts silently to nothing

  nil.to_s           # => ""     empty string
  nil.to_i           # => 0
  nil.to_f           # => 0.0

This is convenient ("".to_i is also 0) but dangerous — a buggy nil becomes a
silent zero instead of an error. Watch for it.

Lesson 5: Arrays and strings convert in both directions

  "a,b,c".split(",")     # => ["a", "b", "c"]   string → array (cut on separator)
  "a b c".split          # => ["a", "b", "c"]   split on whitespace by default
  [1, 2, 3].join("-")    # => "1-2-3"           array → string (glue between items)
  ["a", "b"].join        # => "ab"              join with no glue

Lesson 6: to_h and to_a on tricky inputs

  [[:a, 1], [:b, 2]].to_h   # => {a: 1, b: 2}   array of pairs → hash
  {a: 1}.to_a               # => [[:a, 1]]      hash → array of pairs
  [1, 2].to_h               # TypeError!        not pairs → error

Lesson 7: String() and friends — strict, universal wrappers

There's also a strict family that works on ANY object:

  String(123)     # => "123"     (String() is basically to_s, but strict)
  Array([1,2])    # => [1, 2]
  Array(1)        # => [1]       wraps a non-array in an array
  Array(nil)      # => []

Lesson 8: The traps, collected

Trap A — to_i is lenient: "12abc".to_i → 12. If you want "the whole string must
be a number", use Integer("12abc") which raises.

Trap B — to_i truncates instead of rounding: 3.99.to_i → 3. Surprising for
newcomers who expect 4. Use .round.

Trap C — "3.99".to_i → 3, not 39. It stops at the decimal point. Convert to
float first if you have decimals: "3.99".to_f.

Trap D — nil.to_i → 0 silently hides bugs. A missing value becomes a zero.

Trap E — to_h on an array that isn't pairs raises TypeError. Only arrays of
[key, value] pairs convert cleanly.

The whole thing in one sentence
Use to_i/to_f/to_s/to_a for quick, forgiving conversions (and remember they
truncate, ignore junk, and turn nil into zero); use Integer()/Float()/String()
when you need strict validation that raises on bad input.
