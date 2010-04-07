(* Another List module other than standard List module *)

module M : Type.S =
struct
  type 'a stack = 'a list

  let empty = []
  let isEmpty s = s = []
  let cons x s = x :: s
  let head s = List.hd s
  let tail s = List.tl s
end
