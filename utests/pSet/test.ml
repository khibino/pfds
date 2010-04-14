module Int =
struct
  type t = int

  let eq = (=)
  let lt = (<)
  let leq = (<=)
end

(* module T0 = Test.Test(PSet.Unbalanced.Make(Test.Int));; *)
(* module T1 = Test.Test(PSet.RedBlack.Make(Test.Int));; *)

module Test(Set : PSet.Type.S with type elt = Int.t) =
struct

  let test_data = ref Set.empty
  let test_size = 10000

  let make_data () =
    let rec make_data rv = function
      | n when n >= 0 -> make_data (Set.insert n rv) (n - 2)
      | _ -> rv
    in
    let () = test_data := make_data Set.empty test_size in
      !test_data

  module F = Printf

  let member_assert ele tree bool =
    let v = Set.member ele tree in
      if bool <> v then
        F.printf "input: %d, expect %s but %s\n"
          ele
          (if bool then "true" else "false")
          (if v then "true" else "false")

  let t0 () =
    let d = make_data () in
    let rec t0 = function
      | n when n >= 0 ->
          let _ = (member_assert n d true, member_assert (n + 1) d false) in
            t0 (n - 2)
      | _ -> ()
    in t0 test_size
       
end
