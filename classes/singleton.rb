Lesson 1: Every object is born from one family tree

Ruby is single-inheritance: every object's class has exactly one parent (superclass),
climbing up to a single root. Say hello to the family tree:

  BasicObject        <- the root. Nothing above it (superclass is nil)
      ↑ superclass
    Object           <- Kernel is mixed into Object, so its methods are everywhere
      ↑ superclass
    Module           <- a class is a module with extra powers
      ↑ superclass
    Class            <- every class is an *instance* of Class
      ↑ superclass
    Foo              <- your class
      ↑ superclass
    foo = Foo.new    <- your object (not a class, so it has no superclass)

Ancestors = the whole chain, including mixed-in modules:

class Foo; end
p Foo.ancestors      # => [Foo, Object, Kernel, BasicObject]

This chain is what constant_lookup.rb called "the family tree" — when a constant isn't
in your nesting rooms, Ruby climbs these ancestors to find it.

Lesson 2: The twist — classes are objects, so there's a second tree

Class, Module, Object and BasicObject are themselves objects. And every object can own
a private, anonymous class called its SINGLETON CLASS (a.k.a. eigenclass or ghost class).
It holds methods that apply to ONLY that one object.

For a class, its singleton class is where "class methods" live:

class Foo
  def self.classy; :classy; end   # lands in #<Class:Foo>, NOT in Foo
end

Foo.classy                         # => :classy
Foo.singleton_class                # => #<Class:Foo>
Foo.classy                         # callable because Foo's singleton_class has it

An instance's singleton class sits between the instance and its class:

foo = Foo.new
def foo.only_me; :solo; end        # singleton method — lives in foo's ghost class
foo.singleton_class                # => #<Class:#<Foo:...>>
foo.only_me                        # => :solo

Rules of the ghost class:
  1. It's created lazily — only when you def obj.method, class << obj, or extend.
  2. obj.singleton_class.superclass == obj.class
  3. A CLASS's singleton class inherits from the singleton class of ITS superclass.

Lesson 3: The full diagram

Rules 2 and 3 make the class side run PARALLEL to the object side:

      OBJECT SIDE                    CLASS SIDE (singleton classes)
  ─────────────────────         ─────────────────────────────────
   BasicObject                   #<Class:BasicObject>
        ↑                                ↑
      Object                     #<Class:Object>
        ↑                                ↑
      Module                     #<Class:Module>
        ↑                                ↑
      Class                      #<Class:Class>
        ↑                                ↑
       Foo                       #<Class:Foo>     <- class methods live here
        ↑                                ↑
      Foo.new               #<Class:#<Foo:...>>   <- each instance's own
  (no superclass)                  ↑
                             (each instance's private ghost)

Calling Foo.new walks the CLASS SIDE of the tree:
#<Class:Foo> → #<Class:Object> → #<Class:BasicObject> → Class   (found! Class#new)

Verified live — the class side really skips Foo's own ancestors:

p Foo.singleton_class.superclass       # => #<Class:Object>
p Object.singleton_class.superclass    # => #<Class:BasicObject>
p BasicObject.singleton_class.superclass  # => Class   (back to the object side!)
p Foo.singleton_class.ancestors
# => [#<Class:Foo>, #<Class:Object>, #<Class:BasicObject>, Class, Module, Object, Kernel, BasicObject]

Lesson 4: What the second tree is FOR

Because class Foo < Object makes #<Class:Foo>'s superclass #<Class:Object>, anything
defined on Object's singleton class becomes callable on Foo — THAT is why class methods
inherit, and why every class gets Class#new, Module#name, Object#singleton_class etc.

class << Object
  def object_level_thing; :hi; end
end
Foo.object_level_thing          # => :hi   (inherited down the class side)

Lesson 5: The traps

Trap A — include vs extend are two different floors:
class M; def mo; :m; end; end

class Foo2
  include M     # into Foo2 itself  → Foo2.new.mo works
  extend M      # into #<Class:Foo2> → Foo2.mo works
end

include affects the OBJECT side, extend affects the CLASS side. Same module, two floors.

Trap B — class << Foo is a ghost room (remember constant_lookup.rb Trap B):
Inside class << A, your home is A's singleton class, whose family tree skips A and
starts at #<Class:Object>. So A's OWN constants aren't visible there:

class A
  module B; end
end

class << A
  B     # error! B isn't in #<Class:A>'s ancestry
end

Trap C — singleton_class is a class, not a place to hang instance variables carelessly.
An instance variable on self inside class << obj belongs to the OBJECT, not the ghost.
Use it for methods; keep state in the object.

The whole thing in one sentence
Every class has two trees: the normal one (superclass → BasicObject) for its instances,
and a parallel ghost tree (singleton_class → Class) for itself — and class methods work
because the ghost tree inherits down along the same shape as the real tree.
