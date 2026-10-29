# case statement
# The 'case' statement also known to use === evaluates an expression and matches it against patterns.
# It is similar to switch statements in other languages but more powerful.

# Example 1: Basic case with values
day = "Monday"

case day
when "Monday"
  puts "Start of the work week."
when "Friday"
  puts "Almost the weekend!"
when "Saturday", "Sunday"
  puts "Weekend!"
else
  puts "Midweek."
end


# Example 2: case with ranges
score = 85

grade =
  case score
  when 90..100
    "A"
  when 80..89
    "B"
  when 70..79
    "C"
  when 60..69
    "D"
  else
    "F"
  end

puts "Score #{score} = Grade #{grade}"


# Example 3
x = 5
result = case x
         when 0 then "zero"
         when 1 then "one"
         else "other"
         end

puts result


# Example 4: 
temperature = 35

case
when temperature > 30
  puts "It is hot outside."
when temperature > 20
  puts "It is warm."
when temperature > 10
  puts "It is cool."
else
  puts "It is cold."
end

