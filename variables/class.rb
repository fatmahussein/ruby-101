# class variables begin with @@ sign. They are defined within a class and are shared among all instances of that class. 
# They can be accessed and modified by any instance of the class.

class Dog
  @@legs = 4   # shared by every dog

  def initialize(name) #instance variable
    @name = name
  end

  def info
    "#{@name} has #{@@legs} legs"
  end
end

dog1 = Dog.new("Buddy")
dog2 = Dog.new("Max")

puts dog1.info
puts dog2.info