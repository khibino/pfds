module type S =
sig
  type 'a stack
  val empty   : 'a stack
  val isEmpty : 'a stack -> bool
  val cons    : 'a -> 'a stack -> 'a stack
  val head    : 'a stack -> 'a       (* raises Failure if stack is empty *)
  val tail    : 'a stack -> 'a stack (* raises Failure if stack is empty *)
end
