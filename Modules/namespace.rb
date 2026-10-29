# The scope resolution operator (::) allows you to specify exactly which  class you want to use

module Animals
  class Dog
    def speak
      puts "Woof!"
    end
  end

  class Cat
    def speak
      puts "Meow!"
    end
  end
end

module Robots
  class Dog
    def speak
      puts "Beep beep!"
    end
  end
end

# Access classes through their namespaces
animal_dog = Animals::Dog.new
robot_dog = Robots::Dog.new

animal_dog.speak
robot_dog.speak


cat = Animals::Cat.new
cat.speak
