 Inheritance is when a class inherits behavior from another class. The class that is inheriting behavior is called the `subclass` and the class it inherits from is called the `superclass`.

 Inheritance can be a great way to remove duplication in your code base and keep it DRY.

 # super keyword
 Ruby provides us with the `super` keyword to call methods earlier in the method lookup path. When you call `super` from within a method, it searches the method lookup path for a method with the same name, then invokes it