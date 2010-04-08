module type S =
sig
  type elt
  type set
  val empty : set
  val member : elt -> set -> bool
  val insert : elt -> set -> set
end
