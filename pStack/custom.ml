(* *)

module M : Type.S =
struct
  type 'a stack = Nil | Cons of 'a * 'a stack

  let empty = Nil
  let isEmpty = function Nil -> true | _ -> false
  let cons x s = Cons (x, s)
  let head = function Nil -> raise (Failure "head") | Cons (x, _) -> x
  let tail = function Nil -> raise (Failure "tail") | Cons (_, s) -> s
end
