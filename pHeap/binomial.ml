module Make(Ord : PElem.ORDERED) : Type.S =
struct
  module Elem = Ord

  type tree = Node of int * Elem.t * tree list
  type heap = tree list

  let empty = []
  let isEmpty ts = ts = []

  let rank = function Node (r, x, c) -> r
  let root = function Node (r, x, c) -> x
  let link t_1 t_2 = match (t_1, t_2) with
    | (Node (r, x_1, c_1), Node (_, x_2, c_2)) ->
        if Elem.leq x_1 x_2 then Node (r + 1, x_1, t_2 :: c_1)
        else Node (r + 1, x_2, t_1 :: c_2)

  let rec insTree t = function
    | [] -> [t]
    | (t' :: ts') as ts ->
        if rank t < rank t' then t :: ts else insTree (link t t') ts'

  let insert x ts = insTree (Node (0, x, [])) ts
  let rec merge ts_1 ts_2 = match (ts_1, ts_2) with
    | (ts, []) | ([], ts) -> ts
    | (t_1 :: ts_1', t_2 :: ts_2') ->
        if rank t_1 < rank t_2 then t_1 :: (merge ts_1' ts_2)
        else if rank t_2 < rank t_1 then t_2 :: (merge ts_1 ts_2')
        else insTree (link t_1 t_2) (merge ts_1' ts_2')

  let rec removeMinTree = function
    | []  -> raise (Failure "removeMinTree")
    | [t] -> (t, [])
    | t :: ts ->
        let (t', ts') = removeMinTree ts
        in if Elem.leq (root t) (root t') then (t, ts) else (t', t :: ts')

  let findMin ts = root (fst (removeMinTree ts))
  let deleteMin ts =
    let (Node (_, x, ts_1), ts_2) = removeMinTree ts
    in merge (List.rev ts_1) ts_2
end
