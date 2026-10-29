class Fruit
end

Fruit.new # instance of Fruit class

#A method is a thing your class can do.
class Orange
  def squeeze
    puts "Here's your juice!"
  end
end

orange = Orange.new
orange.squeeze # method call on the instance of Orange class; 


# Instance variables are variables that belong to an instance of a class. They are prefixed with @ and are used to store the state of an object.
class Banana
  def initialize(color)
    @color = color # instance variable
  end

  def color
    @color # accessing instance variable
  end
end

banana = Banana.new("yellow")
puts banana.color # Output: yellow

# eg. 2

class Orange
  def initialize
    @juice_available = 100
  end

  def squeeze
    @juice_available -= 50
  end
end

orangy = Orange.new
puts orangy.instance_variable_get(:@juice_available) # Output: 100
puts orangy.squeeze # Output: nil
puts orangy.instance_variable_get(:@juice_available) # Output: 50

# eg: 3
class CoffeeMachine
  def initialize
    @water = 50
  end

  def print_water_level
    puts "Water Level: #{@water}"
  end
end

machine = CoffeeMachine.new
machine.print_water_level


# Ways of making instance variables accessible outside the class:

# 1. Using attr_reader
class CoffeeMachine
  attr_reader :water

  def initialize
    @water = 100
  end
end

machine = CoffeeMachine.new
puts machine.water # Output: 100

# 2. Using a method to access the instance variable
class CoffeeMachine
  def initialize
    @water = 100
  end

  def water
    @water
  end
end

machine = CoffeeMachine.new
puts machine.water # Output: 100

# 3. Using instance_variable_get method (not recommended for regular use)
class CoffeeMachine
  def initialize
    @water = 100
  end
end

machine = CoffeeMachine.new
puts machine.instance_variable_get(:@water) # Output: 100

# 3. Using  attr_writer — creates a setter only (water=), lets you change the value from outside:
class CoffeeMachine
  attr_writer :water

  def initialize
    @water = 100
  end
end

machine = CoffeeMachine.new
machine.water = 75

# attr_accessor — shorthand for both reader + writer:
class CoffeeMachine
  attr_accessor :water

  def initialize
    @water = 100
  end
end

machine = CoffeeMachine.new
puts machine.water      # 100 (read)
machine.water = 75      # write
puts machine.water      # 75