module Make(Ord : PElem.ORDERED) : Type.S =
struct
  module Elem = Ord

  type heap = E | T of (int * Elem.t * heap * heap)

  let rank = function
    | E -> 0
    | T (r, _, _, _) -> r

  let makeT x a b =
    if rank a > rank b then T (rank b + 1, x, a, b)
    else T (rank a + 1, x, b, a)

  let empty = E
  let isEmpty = function | E -> true | _ -> false

  let rec merge x y = match (x, y) with
    | (h, E) -> h
    | (E, h) -> h
    | ( (T (_, x, a_1, b_1) as h_1), (T (_, y, a_2, b_2) as h_2) ) ->
        if Elem.leq x y then makeT x a_1 (merge b_1 h_2)
        else makeT y a_2 (merge h_1 b_2)

  let insert x h = merge (T (1, x, E, E)) h

  let findMin   = function | E -> raise (Failure "findMin") | T (_, x, a, b) -> x
  let deleteMin = function
    | E -> raise (Failure "deleteMin")
    | T (_, x, a, b) -> merge a b
    
end
