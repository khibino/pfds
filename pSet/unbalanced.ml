module Make(Ord : PElem.ORDERED) : Type.S with type elt = Ord.t =
struct

  type elt = Ord.t

  type tree = E | T of (tree * elt * tree)
  type set = tree

  let empty = E

  let rec orig_member x = function
    | E -> false
    | T (a, y, b) when Ord.lt x y -> orig_member x a
    | T (a, y, b) when Ord.lt y x -> orig_member x b
    | T (a, y, b) -> true

  let member x tree =
    let rec member cand x = function
      | E              -> begin match cand with
          | Some cv when Ord.eq cv x -> true
          | _                        -> false
        end
      | T (a, y, b) when Ord.lt x y ->
          member cand x a
      | T (a, y, b) ->
          member (Some y  (* replace candidate *) ) x b
    in
      member None x tree

  let rec orig_insert x = function
    | E                           -> T (E, x, E)
    | T (a, y, b) when Ord.lt x y -> T (orig_insert x a, y, b)
    | T (a, y, b) when Ord.lt y x -> T (a, y, orig_insert x b)
    | T (a, y, b) as s -> s

(*
  exception Need_to_insert of tree
  let rec fc_insert x =
    function
      | E                                -> raise (Need_to_insert (T (E, x, E)))
      | T (a, y, b) as s when Ord.lt x y -> begin
          try let _ = fc_insert x a in s with
            | Need_to_insert (ins) -> raise (Need_to_insert (T (ins, y, b)))
        end
      | T (a, y, b) as s when Ord.lt y x -> begin
          try let _ = fc_insert x b in s with
            | Need_to_insert (ins) -> raise (Need_to_insert (T (a, y, ins)))
        end
      | T (a, y, b) as s -> s
*)

  (* Exercise 2.3 の exception を有効に利用した実装が不明 *)
  (* exception である必要が無いように見える *)
  let fc_insert x tree =
    let rec fc_insert x =
      function
        | E                                -> Some (T (E, x, E))
        | T (a, y, b) when Ord.lt x y -> begin match fc_insert x a with
            | Some ins -> Some (T (ins, y, b))
            | None     -> None
          end
        | T (a, y, b) when Ord.lt y x -> begin match fc_insert x b with
            | Some ins -> Some (T (a, y, ins))
            | None     -> None
          end
        | T (a, y, b) -> None
    in
      match fc_insert x tree with
        | Some ins -> ins
        | None     -> tree

  (* Exercise 2.3 の exception を有効に利用した実装が不明 *)
  (* Exercise 2.4 は Exercise 2.3 の応用 *)
  let insert x tree = 
    let rec insert cand x = function
      | E                           -> begin match cand with
          | Some cv when Ord.eq cv x -> None
          | _                        -> Some (T (E, x, E))
        end
      | T (a, y, b) when Ord.lt x y -> begin match insert cand x a with
          | Some ins -> Some (T (ins, y, b))
          | None     -> None
        end
      | T (a, y, b)                 -> begin
          match insert (Some y  (* replace candidate *) ) x b with
            | Some ins -> Some (T (a, y, ins))
            | None     -> None
        end
    in
      match insert None x tree with
        | Some ins -> ins
        | None     -> tree

end
