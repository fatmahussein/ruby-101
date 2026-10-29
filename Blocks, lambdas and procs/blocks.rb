# Form 1: recommended for single line blocks
[1, 2, 3].each { |num| puts num }
 
# Form 2: recommended for multi-line blocks
[1, 2, 3].each do |num|
  puts num
end

# using blocks with methods
def print_once
  yield
end

print_once { puts "Block is being run" }

# using blocks with methods that take parameters
def print_twice
  yield
  yield
end   
              
print_twice { puts "Hi" }

# using blocks with methods that take parameters
def one_two_three
  yield 1
  yield 2
  yield 3
end

one_two_three { |number| puts number * 10 }
# 10, 20, 30

# yield returns the value of the block's last expression
def double
  yield(5) * 2
end

double { |number| number + 1 }
# block returns 6 (5 + 1), then the method does 6 * 2 => 12

# explicit block example
def explicit_block(&block)
  block.call # same as yield
end

explicit_block { puts "Explicit block called" }

# How to check if a block is given
def do_something_with_block
  return "No block given" unless block_given?
  yield
end

do_something_with_block { puts "Block is being run" }
do_something_with_block # "No block given"


