A block is a chunk of anonymous code you pass to a method.

Blocks are enclosed in a `do / end` statement or between brackets {}, and they can have multiple arguments.

The argument names are defined between two pipe | characters.

Ruby `Yield` Keyword:
What does `yield` mean in Ruby?
 - Yield is a Ruby keyword that calls a block when you use it.
 - It’s how methods USE blocks!  
 - When you use the yield keyword, the code inside the block will run & do its work.

Implicit vs Explicit Blocks
 
Implicit Blocks
 - An implicit block is passed to a method WITHOUT naming it in the parameter list.
 - The method can only access it through the `yield` keyword.
 - There is no variable holding the block, so you cannot store it, pass it on, or inspect it.
 - Because there is no variable, use `block_given?` to check if a block was passed.
 - Calling yield with no block raises a LocalJumpError, so guard with block_given?.

```ruby
def greet
  yield
end

greet { puts "Hi" }   # { puts "Hi" } is the implicit block
```

 - From the caller's side, implicit and explicit look identical: `greet { ... }`
 - The difference is only inside the method.

   Implicit          |  Explicit (&block)
   ------------------|-------------------
   Not named         |  Named as a Proc
   Called with yield |  Called with yield or block.call
   Cannot store/pass |  Can store and pass on

Explicit Blocks
 - An explicit block is given a name in the parameter list using the `&` prefix.
 - The `&` turns the block into a Proc object, so the name is a real variable.
 - You can call it with `block.call` (same as `yield`).
 - Because it is a variable, you can also check `block.nil?`, store it, return it,
   or pass it to another method as `other_method(&block)`.

```ruby
def greet(&block)   # &block captures the block into a Proc
  block.call        # same as yield
end

greet { puts "Hi" }
```

