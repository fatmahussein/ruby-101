# if / elsif / else
# These are the most basic conditional statements in Ruby.
# Ruby checks each condition in order and executes the first one that is true.

# Example 1:  if
age = 20

if age >= 18
  puts "You are an adult."
end


# Example 2: if / else
number = 7

if number.even?
  puts "#{number} is even."
else
  puts "#{number} is odd."
end


# Example 3: if / elsif / else
score = 75

if score >= 90
  puts "Grade: A"
elsif score >= 80
  puts "Grade: B"
elsif score >= 70
  puts "Grade: C"
elsif score >= 60
  puts "Grade: D"
else
  puts "Grade: F"
end

# Example 4: Inline if 
name = "Alice"
puts "Hello, #{name}!" if name && !name.empty? 
# Output: Hello, Alice!


# Example 5: Inline 
password = ""
puts "Password is empty!" if password.empty?


# Example 6: if as a value (returns the result)
age = 20
status = if age >= 18
           "adult"
         else
           "minor"
         end
# status = age >= 18 ? "adult" : "minor"

puts status


# Example 7: Multiple conditions with && and ||
temperature = 28
is_sunny = true

if temperature > 25 && is_sunny
  puts "Perfect day for the beach!"
elsif temperature > 25 && !is_sunny
  puts "Hot but cloudy."
else
  puts "Not beach weather."
end


# Example 8: Nested if (use sparingly)
has_ticket = true
age = 16

if has_ticket
  if age >= 18
    puts "Welcome to the show!"
  else
    puts "You need an adult guardian."
  end
else
  puts "Please buy a ticket."
end
# Output: You need an adult guardian.
