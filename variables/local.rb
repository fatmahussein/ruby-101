# local variables live within the scope of a method or block and are not accessible outside of that scope.
def make_sum
  a = 3        # local variable
  b = 4        # local variable
  a + b
end

puts make_sum