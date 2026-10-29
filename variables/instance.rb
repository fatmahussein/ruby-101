# Instance variables begin with @ sign. 
# They are accessible only within the instance of the class in which they are defined.

class Class1
   def initialize
      @number = 20
   end
   def print_instance
      puts "Instance variable in Class1 is #@number"
   end
end

class Class2
  attr_accessor :number
  # This line creates getter and setter methods for the @number instance variable, 
  # allowing it to be accessed and modified from outside the class.
 
   def initialize
      @number = 30
   end

   def print_instance
      puts "Instance variable in Class2 is #@number"
   end
end

class1obj = Class1.new
class1obj.print_instance

class2obj = Class2.new
class2obj.print_instance

class2obj.number = 40
class2obj.print_instance

NB: 
attr_accessor expands to 2 methods i.e getter and setter methods for the instance variable @number.
def number
  @number
end

and

def number=(value)
  @number = value
end
