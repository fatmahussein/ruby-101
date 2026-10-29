# Procs
# A proc is a block turned into an object you can store and reuse.

# 1. Defining a proc
square = proc { |n| n * n }
puts square.call(4)   # 16

# 2. Calling it three ways
puts square.call(4)   # 16
puts square.(4)       # 16
puts square[4]        # 16

# 3. Passing a proc as a block with &
nums = [1, 2, 3, 4]
p nums.map(&square)   # [1, 4, 9, 16]
p nums.select { |n| n.even? }  # [2, 4]

# 4a. Procs are lenient about arguments (like blocks)
add = proc { |a, b| "#{a} + #{b}" }
puts add.call(1)        # "1 + "   (missing b is nil)
puts add.call(1, 2, 3)  # "1 + 2"  (extra ignored)

# 4b. return inside a proc exits the enclosing method
def test
  p1 = proc { return "from proc" }
  p1.call
  "end of method"   # never reached
end
puts test   # "from proc"


