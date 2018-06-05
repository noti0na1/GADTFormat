open GADTFormat

(* "Digit: %d%s" *)
let fs0 r = lit "Digit: " @@ dig @@ str r

(* fs1 : int -> string -> string *)
let fs1 = sprintf @@ to_str fs0

(*
  append format string:
  "Digit: %d%s, Digit: %d%s"
*)
let fs2 r = fs0 @@ lit ", " @@ fs0 r

(* fs3 : int -> string -> int -> string -> string *)
let fs3 = printf @@ to_out fs2

let _ =
    print_endline @@ fs1 3 "c";
    fs3 1 "a" 2 "b\n"
