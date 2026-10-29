class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal # < means "inherits from"; methods from the parent class are available to the child class
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak          
puts paws.speak

# What if we want to add a name to our GoodDog class? We can do that by adding an initialize method and an instance variable @name. 
# We can also override the speak method to include the dog's name in the output.

class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak # we're overriding the speak method in the Animal class because Ruby checks the object's class first for the method before it looks in the superclass.
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => Sparky says arf!
puts paws.speak             # => Hello!