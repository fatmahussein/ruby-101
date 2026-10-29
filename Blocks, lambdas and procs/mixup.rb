# Proc
say_hi = Proc.new { |name| "Hi #{name}" }
puts say_hi.call("Fatma")

# Lambda
add = ->(a, b) { a + b }
puts add.call(2, 3)

# A closure is a function that "closes over" the lexical environment where it was defined: 
# it captures the local variables in scope and keeps them alive and shared, 
# even after that scope has exited. In Ruby, procs, lambdas, and blocks are all closures.

# Closure retains access to variables from its defining scope
name = "Fatma"
greet = -> { "Hello #{name}" }
name = "Ruby"
puts greet.call

# Closure with its memory of the variable's value at the time of its definition
def counter
  n = 0
  -> { n += 1 }
end

c = counter
puts c.call
puts c.call
puts c.call

# Binding example , a snapshot of the current variable bindings, which can be used to evaluate code in that context.
x = 10
b = binding
puts b.eval("x + 5")
b.local_variable_set(:x, 99)
puts x

# return: lambda vs proc
l = -> { return 1 }
puts "lambda: #{l.call}"

def m
  p = Proc.new { return 1 }
  p.call
  2
end
puts "proc: #{m}"
