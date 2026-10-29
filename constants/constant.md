1. For each class or module in Module.nesting in order, see if the constant exists in its constant table.

2. Each time we use the  `class` or `module` KEYWORDS(or `class_eval` or `module_eval` with a `string` passed) , we add an entry to the front of Module.nesting. We remove it when we use hit the corresponding `end` keyword. 

more Questions:
 class_eval, ::B, Class.new, A.class_eval{B} vs A.class_eval("B")

3. If we do not find it through the `Module.nesting` then we will look through the ancestors of the first entry of the `Module.nesting` or `Object.ancestors`
  - If Module.nesting is empty, then look through `Object.ancestors`
  - Otherwise, look through `Module.nesting.first.ancestors`