# ######## Ancestral Constant Lookup #######

puts "Question 1:"

class A
  VOO = 1
end

class B < A
  pp VOO
  pp Module.nesting
  pp ancestors
  # def voo
  #   pp VOO
  # end
  end

  B.define_method(:voo) {VOO}
  puts B.new.voo

