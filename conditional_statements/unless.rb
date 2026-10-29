# unless keyword
# The 'unless' keyword is the opposite of 'if'.
# It executes the block only when the condition is FALSE.

# Example 1: Basic unless
age = 20

unless age < 18
  puts "You are an adult."
end


# Example 2: unless with else
is_raining = false

unless is_raining
  puts "No umbrella needed."
else
  puts "Take an umbrella!"
end


# Example 3: Inline unless (modifier form)
temperature = 30
puts "It is hot!" if temperature > 25

# The above is equivalent to:
puts "It is hot!" unless temperature <= 25



# Example 4: unless with a method
def greet(name)
  puts "Hello, #{name}!" unless name.nil?
end

greet("Alice")
greet(nil)


# Example 5: unless with multiple conditions
score = 85

unless score < 60 || score > 100
  puts "You passed the test."
else
  puts "Invalid score or failed."
end

# Example 7: unless with array
items = []

unless items.empty?
  puts "You have #{items.length} items."
else
  puts "Your cart is empty."
end

