# Procs

A proc is a block turned into an object, so you can store it in a variable and reuse it.

## 1. Making one

```ruby
square = proc { |n| n * n }
```

That's it. `square` is a variable holding a proc (the block `|n| n * n` captured as an object).

## 2. Running it

A proc isn't run when defined - you call it later, three equivalent ways:

```ruby
square.call(4)   # => 16
square.(4)       # => 16  (syntactic sugar)
square[4]        # => 16
```

`.call` is the clear one; `.()` and `[]` are shortcuts.

## 3. Why bother (vs a block)

A block exists only for the duration of one method call. A proc can be:

 - stored in a variable
 - reused many times
 - passed around as a normal object

```ruby
nums = [1, 2, 3, 4]
nums.map(&square)   # => [1, 4, 9, 16]
nums.select { |n| n.even? }
```

Here `&square` is the expand direction of `&`: it takes the proc and hands it to `map` as a block.

## 4. Procs behave like blocks

Two behaviours, both matching blocks (and unlike lambdas):

### a) Lenient about arguments - no error if the count is off

```ruby
add = proc { |a, b| "#{a}-#{b}" }
add.call(1)        # => "1-"   (missing b is nil)
add.call(1, 2, 3)  # => "1-2"  (extra ignored)
```

### b) return returns from the enclosing method, not the proc

```ruby
def test
  p = proc { return "from proc" }
  p.call
  "end of method"   # never reached
end

test   # => "from proc"
```

