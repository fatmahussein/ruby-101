
The main use of a class is to be a container of methods,instance variables & constants, forming a blueprint from which you can create objects.

 To create an object use Class.new ; The process of creating an object is known as “instantiation”, and the object is called an “instance” of that class.

### Why create objects?
Because every object you create is different & unique.

Every object has its own identity.

### How to Make Ruby Classes More Useful
Classes become more useful when you start adding instance methods & instance variables to them.

A method is a thing your class can do eg. orange.squeeze. These methods becomes commands for your objects.
Every Orange object you create will have access to this squeeze method & that’s one of the benefits of using classes.

# instance variable
Instance variables are different from local variables because they start with the @ symbol. You can’t access them outside the class unless you define an `attr_accessor`.
You can read an instance variable value with the @ syntax. eg: `puts "Water Level: #{@water}"`

In Rails, instance variables (like @books), are used to share data between your controller & views.
