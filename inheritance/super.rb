class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class" 
  end
end

sparky = GoodDog.new
sparky.speak        # => "Hello! from GoodDog class"

# Eg 2

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")   

# Eg 3

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear")

# Eg 4

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")       

Why super() and not super?
- super() → calls Animal#initialize with no arguments (empty parentheses)
- super → forwards all arguments from the current method — so it would call Animal#initialize("black")
But Animal#initialize takes no parameters, so passing "black" raises an error (wrong number of arguments).