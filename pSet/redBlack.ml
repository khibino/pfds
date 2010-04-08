module Make(Ord : PElem.ORDERED) : Type.S with type elt = Ord.t =
struct

  type elt = Ord.t

  type color = R | B
  type tree = E | T of (color * tree * elt * tree)

  type set = tree

  let empty = E

  (* original member function *)
  let rec orig_member x = function
    | E              -> false
    | T (_, a, y, b) when Ord.lt x y -> orig_member x a
    | T (_, a, y, b) when Ord.lt y x -> orig_member x b
    | T (_, a, y, b) -> true
              

  (* Optimizing with exercise 2.2 *)
  let member x tree =
    let rec member cand x = function
      | E              -> begin match cand with
          | Some cv when Ord.eq cv x -> true
          | _                        -> false
        end
      | T (_, a, y, b) when Ord.lt x y ->
          member cand x a
      | T (_, a, y, b) ->
          member (Some y  (* replace candidate *) ) x b
    in
      member None x tree

  let rec balance = function
    | (B, T (R, T (R, a, x, b), y, c), z, d)
    | (B, T (R, a, x, T (R, b, y, c)), z, d)
    | (B, a, x, T (R, T (R, b, y, c), z, d))
    | (B, a, x, T (R, b, y, T (R, c, z, d))) -> T (R, T(B, a, x, b), y, T (B, c, z, d))
    | body -> T body

  let insert x s =
    let rec ins = function
      | E -> T (R, E, x, E)
      | T (color, a, y, b) as s -> begin match x with
          | _ when Ord.lt x y -> balance (color, ins a, y, b)
          | _ when Ord.lt y x -> balance (color, a, y, ins b)
          | _ -> s
        end
    in
      match ins s with
        | T (_, a, y, b) -> T (B, a, y, b)
        | E -> assert false

end
