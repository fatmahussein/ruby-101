# Lambdas
# A lambda is a proc with two stricter rules: strict arity + local return.

# 1. Defining a lambda (two identical forms)
square = lambda { |n| n * n }
square2 = ->(n) { n * n }
puts square.call(4)    # 16
puts square2.call(5)   # 25

# 2. Calling three ways
puts square.call(4)    # 16
puts square.(4)        # 16
puts square[4]         # 16

# 3a. Strict about arguments (procs are lenient)
strict = lambda { |a, b| "#{a}-#{b}" }
puts strict.call(1, 2) # "1-2"


# 3b. return returns from the lambda itself, not the enclosing method
def test_lambda
  l = lambda { return "from lambda" }
  l.call
  "end of method"   # reached
end
puts test_lambda   # "end of method"

# Compare: return in a proc exits the whole method
def test_proc
  p1 = proc { return "from proc" }
  p1.call
  "end of method"   # not reached
end
puts test_proc     # "from proc"

# 4. Checking
puts lambda {}.lambda?   # true
puts proc {}.lambda?     # false
