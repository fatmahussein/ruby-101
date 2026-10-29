THE FAMILY TREE AND SINGLETON CLASSES — the whole story, in order
Read it top to bottom. Every lesson builds on the one before it.

Lesson 1: Everything is an object, and every object has a class

  "hi".class     # => String
  42.class       # => Integer
  ann.class      # => Person

That's the whole foundation. Now the one weird line — classes are objects too:

  Person.class   # => Class

`class Person` didn't just create a house, it created an object (of class `Class`)
and gave it the name Person. Everything else below is just these rules clicking together.

Lesson 2: Method lookup — the single rule that runs Ruby

When you call `ann.speak`, Ruby asks ONE question:

  "What is ann's class? Search there.
   Not found? Search that class's parent, then grandparent..."

The list of "parents" a class searches is its `ancestors`:

  class Person
    def speak; :hello; end
  end

  ann = Person.new
  ann.class.ancestors    # => [Person, Object, Kernel, BasicObject]

`ann.speak` → search Person → found `speak`. That's it. Every method call in Ruby
is this one question. (This is the "family tree" — a class and its parents.)

Lesson 3: Classes are objects, so the SAME rule gives you class methods

  class Foo; end
  Foo.class     # => Class
  Foo.new       # "what is Foo's class? → Class → found new"

`new` needs no magic. Foo is an object whose class is Class, and `new` lives in Class.
No rooms, no boxes, no secrets. Same rule as `ann.speak`.

Lesson 4: Methods for ONE object only → the box (singleton class)

  ann = Person.new
  bob = Person.new

  def ann.shout
    :LOUD
  end

Where can Ruby store `shout`? Not in Person — that would give it to bob too.
So it builds a small box attached to ann alone and puts `shout` in it.
That box is the singleton class:

  ann.singleton_class    # => #<Class:#<Person:...>>   — ann's box

  ann.shout   # :LOUD   → check ann's box first → found
  bob.shout   # error   → no box → check Person → not found

The box is created ONLY when you need it (def obj.method, class << obj, extend,
or asking for obj.singleton_class). bob doesn't get a box just because ann has one.
And without a box, method lookup is plain: `ann.speak` → ann.class → Person.

Lesson 5: Class methods are the same trick

  class Person
    def self.species; :human; end
  end

`def self.species` literally means "put `species` in Person's box."
The box is `Person.singleton_class`. Residents don't get it:

  Person.species        # :human
  Person.new.species    # error — instances don't see the box

`Person.new` still works even when Person has a box, because `new` lives in `Class`,
and Person's box chain always lands back on `Class` (see Lesson 7).

Lesson 6: include vs extend — two different boxes

  module M
    VALUE = 1
    def m_method; :m; end
  end

  class C
    include M     # M joins C's ancestors (the object side)
  end
  C.ancestors              # => [C, M, Object, Kernel, BasicObject]
  C.new.m_method           # works — instances get it
  C::VALUE                 # works — constants ride the ancestors

  class D
    extend M      # M joins D's box (the class side)
  end
  D.ancestors              # => [D, Object, Kernel, BasicObject]  — M NOT here
  D.singleton_class.ancestors  # => [#<Class:D>, M, ...]           — M is HERE
  D.m_method               # works — D itself gets it (via its box)
  D.new.m_method           # error — instances don't see the box
  D::VALUE                 # error — constants only search ancestors, not the box

One rule: constant lookup climbs `ancestors` (object side). include adds to that,
extend doesn't. That's why "include can see constants and extend can't."

Lesson 7: The whole picture — two sides that merge back together

  OBJECT SIDE (houses)            BOX SIDE (boxes)
  ---------------------           ---------------------
  BasicObject                    #<Class:BasicObject>
       ↑                                ↑
  Object                        #<Class:Object>
       ↑                                ↑
  Module                        #<Class:Module>
       ↑                                ↑
  Class                         #<Class:Class>
       ↑                                ↑
  Person  ────────────────→     #<Class:Person>
       ↑                                ↑
  ann                          #<Class:ann>

- No box: `ann.speak` → ann.class → Person.  `Foo.new` → Foo.class → Class.
- With a box: look in the box first, then its box-parents, and the box chain
  always lands back on `Class` — so `Foo.new` finds `new` either way.

The box side is NOT a separate world. It's a short detour in front of an object
that only exists when that object has special methods.

The whole thing in one sentence
Ruby has one rule — "call a method → search your class, then its parents" —
and everything else is just that rule applied to objects, plus a lazily-created
box (singleton class) in front of any object that needs methods of its own.
