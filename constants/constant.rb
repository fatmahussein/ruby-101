#constants from mixed in modules
# a Module can't be a superclass, the only way to get a module's methods is to include it in a class.
module Mixin
  A = 123
end

class Product
  include Mixin

  puts A
end
# 123

class Products
  extend Mixin

  begin
    puts A
  rescue NameError
    puts "uninitialized constant Products::A"
  end
end

# Why: extend is the SAME operation as include, but on the singleton class.
# Products.extend(Mixin) == Products.singleton_class.include(Mixin)
# So Mixin enters the singleton class's chain, NOT the class's own chain:
puts Products.ancestors
# => [Products, Object, Kernel, BasicObject] — no Mixin

puts Products.singleton_class.ancestors.include?(Mixin)
# => true — Mixin lives in the singleton class's chain

# From the singleton room, the constant IS reachable:
class << Products
  puts A
end
# 123


#When you use a method that has been included from a module, 
# Ruby will look for constants starting where that method is defined.

module Parent
  def print_value
    VALUE
  end
end

class Child
  include Parent

  VALUE = 1
end

# Works cause the line's home is Child, not Parent
p Child::VALUE  => 1 

# uninitialized constant Parent::VALUE
begin
  p Child.new.print_value
rescue NameError => e 
  puts e.message
end