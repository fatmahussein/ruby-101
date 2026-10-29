module Greetings
  def say_hello
    puts "Hello from module!"
  end

  def say_goodbye
    puts "Goodbye from module!"
  end
end

class Person
  include Greetings 
end

person = Person.new
person.say_hello
person.say_goodbye

# The Person class uses include to mix in these methods, making them available to all Person instances


# Eg 2

module MathOperations
  PI = 3.14159

  def square(number)
    number * number
  end

  def cube(number)
    number * number * number
  end

  def circle_area(radius)
    PI * square(radius)
  end
end

class Calculator
  include MathOperations

  def calculate_volume(radius, height)
    circle_area(radius) * height
  end
end

calc = Calculator.new
puts "5 squared: #{calc.square(5)}"
puts "3 cubed: #{calc.cube(3)}"
puts "Circle area (radius 4): #{calc.circle_area(4)}"
puts "Cylinder volume: #{calc.calculate_volume(3, 10)}"

# Key concept: constants are shared with including classes,
# methods within the module can call each other, and classes can build upon module functionality with their own methods.