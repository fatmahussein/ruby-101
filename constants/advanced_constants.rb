# Advanced constants — warnings, freezing, dynamic access, and the traps
# Lesson 1: Constants warn, they don't lock

# Reassigning a constant is NOT an error. Ruby prints a warning and lets the
# new value win. The "constant" name is a hint, not a jail.
PI = 3.14
PI = 3.15              # warning: already initialized constant PI
puts PI                # => 3.15  (the change stuck)

# If you truly want a value that cannot change, you must freeze it.

# Lesson 2: Freezing — the real lock

FIXED_GREETING = "jambo".freeze
begin
  FIXED_GREETING << ", world!"
rescue FrozenError => e
  puts "FrozenError: #{e.message}"
end

# The trap — freeze is SHALLOW. A frozen Array/Hash cannot change shape
# (no <<, no []=, no delete), but the objects inside it are still mutable
# unless they are frozen individually.
FRUITS = ["apple"].freeze
begin
  FRUITS << "kiwi"     # FrozenError — changing the container is blocked
rescue FrozenError
  puts "can't append to a frozen Array"
end

FRUITS[0].upcase!      # works — the string "apple" is NOT frozen
p FRUITS               # => ["APPLE"]
p FRUITS.frozen?       # => true   (the Array is frozen)
p FRUITS[0].frozen?    # => false  (the String inside is not)

# Deep-freezing every element by hand:
DEEP = ["one", "two"].map(&:freeze).freeze

# Lesson 3: Built-in constants — Ruby ships with ready-made ones

p RUBY_VERSION         # => "3.4.2"
p RUBY_ENGINE          # => "ruby"
p RUBY_PLATFORM        # => platform string, e.g. "x86_64-linux"
p Math::PI             # => 3.141592653589793
p Float::INFINITY      # => Infinity
p ENV["HOME"]          # ENV is a constant Hash of your environment variables
p ARGV                 # ARGV is a constant Array of command-line arguments

# NOT every obvious name exists: Integer::MAX raises NameError in this version.

# __FILE__, __LINE__ and __dir__ are magic constants Ruby maintains for you:
p __FILE__             # absolute path of the file running right now
p __LINE__             # the current line number
p __dir__              # the directory that contains this file

# Lesson 4: Dynamic constant access — constants by name at runtime

class Box
  SIZE = 10
end

Box.const_get(:SIZE)         # read a constant from a name — same as Box::SIZE
p Box.const_defined?(:SIZE)  # => true  (does Box::SIZE exist?)
Box.const_set(:WEIGHT, 5)    # define a constant dynamically — same as Box::WEIGHT = 5
p Box::WEIGHT                # => 5
Box.send(:remove_const, :WEIGHT)   # delete it (remove_const is private)
p Box.const_defined?(:WEIGHT)      # => false

# const_defined? also accepts strings and looks through ancestors by default:
Box.const_defined?("SIZE")   # => true

# Lesson 5: defined? — the safe existence check

p defined?(Math::PI)         # => "constant"
p defined?(RUBY_VERSION)     # => "constant"
p defined?(MISSING_CONST)    # => nil  (no error — just nil)

# Handy for guarded use:
puts Math::PI if defined?(Math::PI)

# Lesson 6: The traps, collected

# Trap A — a constant cannot be defined inside a method.
# Ruby rejects it at parse time: "dynamic constant assignment" (SyntaxError).
# def make
#   A = 1
# end

# Trap B — defining a constant in a loop reassigns it every iteration.
# Ruby spams the already-initialized warning once per repeat.
3.times do |i|
  LOOP_C = i
end

# Trap C — the frozen_string_literal magic comment. It must be the FIRST
# line of the file, and it freezes every string literal in that file:
#   # frozen_string_literal: true
# (This file doesn't use it, so our strings above are mutable by default.)

# Trap D — freeze stops mutation, but nothing stops const_set.
# Even a frozen class can receive new constants.
FRZ = Object.new.freeze
p FRZ.frozen?                # => true

# The whole thing in one sentence
# A constant is a warning-shaped variable (reassignment prints a warning,
# then obeys); freeze is what actually locks a value, and it only locks the
# container, not the things inside it.
