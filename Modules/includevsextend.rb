module Speakable
  def greet
    puts "Hello from #{self.class}"
  end
end

class Person
  include Speakable
end

class Robot
  extend Speakable
end

# include makes module methods available to instances
person = Person.new
person.greet

# extend makes module methods available to the class itself
Robot.greet

# This won't work - Robot instances don't have access
# robot = Robot.new
# robot.greet  # This would raise an error

# The key distinction: include adds methods to class instances, while extend adds them to the class itself.
# Choose include when you want to add behavior to objects, and extend when you want to add class-level functionality.