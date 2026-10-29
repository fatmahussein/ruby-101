#Module.nesting shows the chain of modules.
puts "Question 1:"
 pp Module.nesting 

 puts "Question 2:"
  module A
    pp Module.nesting 
  end
  
  puts "Question 3:"
  module A
    class << self
      def print_nesting
        pp Module.nesting
      end  
    end
  end

  A.print_nesting

puts "Question 4:"
  class B
    FOO = 1
    class C
      def foo 
        # pp  Module.nesting => [B::C, B]
        pp FOO
      end
    end
  end

  # B.new.foo
  B::C.new.foo

  puts "Question 5:"

class A
  module M
    pp Module.nesting
  end 
end

class C
  module M 
  end
  A.class_eval("M")
  A.class_eval{M}
  end


puts "Question 6:"
Class A
 module B; end
end

class << A
  B
end

