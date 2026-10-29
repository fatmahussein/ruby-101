Ruby naming conventions — the shapes that make code self-explanatory

Lesson 1: The one rule Ruby ENFORCES — case matters

A name starting with a CAPITAL letter is a constant. Anything else is a variable.

  Cat = "cat"      # constant — Ruby warns if you reassign it
  cat = "cat"      # local variable — free to change

The subtlety: a bare, capitalised word is always read as a constant reference.
`Cat` alone means "the constant Cat", while `cat()` is the method cat.
(Oddly, `def Cat` IS legal and creates a method called Cat — terrible style,
but Ruby won't stop you. This is why the convention matters.)

That's essentially the only naming rule Ruby enforces at all. Everything else
below is convention (strong convention, but convention). A class is just a
constant that holds a Class object — which is why class names are capitalised.

Lesson 2: snake_case for variables and methods

  first_name = "Fatma"
  bank_account.balance

  def total_price
    # ...
  end

Lowercase letters, words joined by underscores. No camelCase, no hyphens.

Lesson 3: CamelCase for classes and modules

  class BankAccount   # not BankAccount_ or bank_account
  module PaymentGateway
  end

One word per part, each starting with a capital. File naming pairs with it:

  bank_account.rb   defines   BankAccount
  payment_gateway.rb defines  PaymentGateway

Lesson 4: Constants — SCREAMING_SNAKE_CASE

  MAX_RETRIES = 3
  DEFAULT_TIMEOUT = 30

The trap: Ruby does NOT require this. Ruby accepts CONSTANT_CASE,
CamelCase, even lowercase for constants. Style guides pick all-caps so a
constant is recognisable at a glance. (Ruby's only complaint: reassigning a
constant prints a warning.)

Lesson 5: Instance and class variables — the @ marks

  @first_name     # instance variable — belongs to one object
  @@shared        # class variable — shared by the whole class (avoid; prefer class instance variables)
  $global         # global variable — avoid entirely

  attr_accessor :name     # generates @name plus name/name= methods

Lesson 6: The special suffixes — ? and ! are part of the NAME

  def empty?; end        # ? = "returns true/false" → predicate methods
  def save!; end         # ! = "dangerous version" → bang methods

  names.empty?           # reads like a question
  str.upcase!            # changes str in place instead of returning a copy

The ! convention has a rule attached: only use ! when a SAFE version also
exists (save/save!, upcase/upcase!). If there's no safe counterpart,
don't add the !. And ? is reserved for methods that return a boolean.

Lesson 7: Symbols, files, and acronyms

  :first_name       # symbols follow snake_case like variables
  :name=

  file names match the main class they define, snake_case.rb.

  XMLParser / XmlParser   # both seen in the wild; pick one and stay consistent.
  # Ruby's own stdlib leans to capitalised acronyms: JSON, XML, CSV.

Lesson 8: The traps, collected

Trap A — a capitalised first letter silently makes a constant. Typos like
`Name = "Fatma"` inside a method define a constant, not a local variable.

Trap B — methods can end in ? or !, variables cannot. `def empty?` is legal,
but `empty? = 5` is a syntax error.

Trap C — class names and constants share the same namespace. You cannot have
both a class and a constant called `Foo` in the same scope.

Trap D — don't put a capital at the start of a method name, and don't put an
underscore at the start of a method that should be public — by convention a
leading underscore (like _helper) means "private".

The whole thing in one sentence
Ruby only enforces "capital letter = constant"; everything else — snake_case
for variables/methods, CamelCase for classes, SCREAMING_CASE for constants,
? for booleans, ! for dangerous versions — is convention that makes your code
readable at a glance.
