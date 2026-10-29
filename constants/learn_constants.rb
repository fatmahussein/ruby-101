# Step 1: What is a constant?

# A constant is a name that stores a value. 

SCHOOL_NAME = "ABC High School"

puts SCHOOL_NAME   # => ABC High School


# Step 2: The capital-letter rule

# Ruby has ONE enforced rule about names: if it starts with a CAPITAL
# letter, it's a constant. Lowercase = variable. That's the whole rule.
Cat = "a cat"      
cat = "a cat"      

# This is also why classes are capitalized:
# class BankAccount   →  BankAccount is a constant holding the class object

# Step 3: Reading a constant

# A bare name reads the constant when you're in the same scope:
puts SCHOOL_NAME   

# To read a constant from OUTSIDE its scope, reach in with ::
class Greeting
  WELCOME = "karibu"
end

module Farewell
  BYE = "kwaheri"
end

puts Greeting::WELCOME   # :: walks into Greeting and reads WELCOME
puts Farewell::BYE       # :: walks into Farewell and reads BYE

# Step 4: Where constants live

# You can define a constant at the top level (we did that in Step 1),
# inside a class, or inside a module. Where you write it decides who
# can see it. A constant is visible inside the box that contains it:
class Profile
  NAME = "Fatma"        # Profile::NAME

  def show
    NAME                # works because we're inside the class
  end
end

puts Profile::NAME       # reach in from outside with ::
puts Profile.new.show    # the method can read it with a bare name

# Step 5: The reassignment warning

# Reassigning a constant is NOT a crash. Ruby prints a warning, then lets
# the new value win. Constants warn ,they don't lock.
PI = 3.14
PI = 3.15                # warning: already initialized constant PI
puts PI                  # => 3.15  (the change stuck anyway)

# If you genuinely need a value that cannot change, use .freeze:
DAYS = ["Mon", "Tue"].freeze

# Step 6: Constants hold mutable values

# Here's a common surprise: you can change what's INSIDE a constant
# without any warning. The warning is only for REassigning the name.
FRUITS = ["apple"]
FRUITS << "kiwi"         # fine — no warning, the array just grew
puts FRUITS.inspect      # => ["apple", "kiwi"]

# Reassigning the name itself is what draws the warning.
# FRUITS = ["mango"]     # warning: already initialized constant FRUITS

# What freeze actually does (a frequent mix-up):

# freeze stops MUTATION — changing the object's contents in place:
FROZEN = ["apple"].freeze
# FROZEN << "kiwi"       # FrozenError: can't modify frozen Array

# freeze does NOT stop reassignment. The name can always be pointed at a
# new object; Ruby just warns:
FROZEN = ["mango"]       # warning: already initialized constant FROZEN

# And numbers (Integer, Float) are ALREADY immutable in Ruby — you can
# never mutate 3.15, so 3.15.freeze changes nothing. That's why this is
# confusing: freezing a number looks like it does nothing, and you can
# still reassign the constant with only a warning.

# Step 7: Test yourself

class Car
  MAX_SPEED = 180
end

puts Car::MAX_SPEED    

TOTAL = 10
TOTAL = 20
puts TOTAL               

NAMES = ["Ana"]
NAMES << "Ben"
puts NAMES.inspect       
