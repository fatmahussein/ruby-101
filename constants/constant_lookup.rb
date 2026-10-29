Lesson 1: Every line of code has a "home"

When Ruby reads your file, every line of code knows which module/class it's typed inside. That's its home. The list of all the open "rooms" surrounding that line is called Module.nesting.
module A
  module C
    module D
      Module.nesting   # => [A::C::D, A::C, A]
      #              current room → outer room → outer-est room
    end
  end
end

module A is secretly Object::A = Module.new. Verified tables:
Object's table  → :A
A's table       → :B
A::B's table    → :C
A::B::C's table → :Greeting


It's literally the stack of rooms you're sitting in: D is inside C, which is inside A.
The trap: shortcuts. This code looks like it's inside A and C, but it isn't:
module A
  module B; end
end

module A::C   # shortcut — Ruby sees ONLY A::C as your home, NOT A
  B           # error! Ruby thinks your home is just A::C
end
With the shortcut, Module.nesting == [A::C] — the room A isn't in your stack anymore.

Lesson 2: The search — home first, then parents

When you type a constant name, Ruby:
1. Checks every room in your nesting stack (from innermost outward)
2. If not found, checks the ancestors of your innermost room (your class's parents, grandparents...)
class A
  module B; end   # B lives here
end


class C < A       # C is A's child
  B               # found! A::B, via C's ancestors
end
C looks for its own B (no), then asks its parents — A has B. Found.
Crucial: this uses the home of the line, not the object you're calling on. Remember our earlier gotcha:
module Parent
  def print_value
    VALUE      # this line's home is Parent
  end
end

class Child
  include Parent
  VALUE = 1
end

Child.new.print_value   # error — the line's home is Parent, not Child
Same rule as Lesson 1 + 2. Methods use "who's calling me" (dynamic); constants use "where was I typed" (static).

Lesson 3: The top of your file = a secret room called Object

At the very top level (no module/class around you), Ruby pretends your home is Object:
module C; end        # secretly becomes Object::C

C == Object::C       # => true
And since almost every class descends from Object, and every lookup checks ancestors, top-level constants are visible almost everywhere. That's why Math::PI and your top-level stuff "just work."
The cool proof: BasicObject doesn't inherit from Object:
class Foo < BasicObject
  Kernel     # error! BasicObject's family tree doesn't include Object
end

# Fix: use the explicit :: to jump straight there
::Kernel     # works
The :: with nothing before it = "start from the absolute top."

Lesson 4: The two sneaky traps

Trap A — blocks don't change your home. When you pass a block to class_eval, the block keeps the home where it was written, not where it runs:
class A
  module B; end
end

class C
  module B; end
  A.class_eval { B }   # => C::B !!
  # the block was written inside C, so B resolves to C::B
end
But if you pass a string instead, the string has no written home, so Ruby uses the eval'd class:

A.class_eval("B")      # => A::B  (string takes A as its home)

Trap B — the class << room is a ghost room. Inside class << A, your home is A's singleton class, whose family tree skips A and starts at Class:
class A
  module B; end
end

class << A
  B          # error! A's own B is not in the singleton class's ancestry
end
The whole thing in one sentence
When Ruby reads a constant, it searches the rooms you're textually inside, then climbs your class's family tree — and only if both fail, it throws NameError.
The article's code at the bottom is just those two steps written out in Ruby:
1. rooms you're inside  → Module.nesting
2. family tree          → (innermost room).ancestors
3. (extra) if your home is a module, also check Object's tree