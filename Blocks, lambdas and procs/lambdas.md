# Lambdas

A lambda is a proc with two stricter rules. 

## 1. Making one

```ruby
square = lambda { |n| n * n }
square = ->(n) { n * n }   # "stabby lambda" - identical to the above
```

`lambda { }` and `->( ) { }` create the same thing.

## 2. Running it

Same as a proc: `.call`, `.()`, or `[]`.

```ruby
square.call(4)   # => 16
square.(4)       # => 16
square[4]        # => 16
```

## 3. Difference from procs

### a) Strict about arguments (procs are lenient)

```ruby
l = lambda { |a, b| "#{a}-#{b}" }
l.call(1)         # ArgumentError: wrong number of arguments (given 1, expected 2)
l.call(1, 2, 3)   # ArgumentError
```

### b) return returns from the lambda itself, not the enclosing method

```ruby
def test
  l = lambda { return "from lambda" }
  l.call
  "end of method"   # reached
end

test   # => "end of method"
```

Compare with a proc, where `return` exits the whole method:

```ruby
def test
  p = proc { return "from proc" }
  p.call
  "end of method"   # NOT reached
end

test   # => "from proc"
```

## 4. Checking

```ruby
lambda {}.lambda?   # => true
proc {}.lambda?     # => false
```
