module type S =
sig
  type elem
  type set
  val empty : set
  val member : elem -> set -> bool
  val insert : elem -> set -> set
end
