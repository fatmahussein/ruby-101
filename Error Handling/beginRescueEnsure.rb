age = 15

if age < 18
  raise "You must be 18 or older"
end

puts "Welcome!"


# Eg 2

begin
  age = 15

  if age < 18
    raise "You must be 18 or older"
  end

  puts "Welcome!"

rescue
  puts "Sorry, you're too young."
end

raise  → creates/throws an exception
rescue → catches/handles the exception
ensure → runs afterward no matter what

begin
  # Code that might cause an error
rescue
  # What to do if an error happens
ensure
  # Code that always runs
end

# Eg 3
begin
  number = 10 / 0
rescue
  puts "Something went wrong!"
ensure
  puts "This always runs."
end


