module type FINITE_MAP =
sig
  type key
  type 'a map
  val empty : 'a map
  val bind  : key -> 'a -> 'a map -> 'a map
  val lookup : key -> 'a map -> 'a (* raise Not_Found if key is not found *)
end
