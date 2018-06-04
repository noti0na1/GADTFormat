type ('a, 'b) t =
  | End : ('a, 'a) t
  | Dig : ('a, 'b) t -> (int -> 'a, 'b) t
  | Str : ('a, 'b) t -> (string -> 'a, 'b) t
  | StrLit : string * ('a, 'b) t -> ('a, 'b) t

let dig = fun r -> Dig r

let str = fun r -> Str r

let lit = fun s -> fun r -> StrLit (s, r)

let to_out : (('a, 'a) t -> ('b, 'a) t) -> ('c, unit) t =
  fun f -> f End

let to_str : (('a, 'a) t -> ('b, 'a) t) -> ('c, string) t =
  fun f -> f End

let rec printf : type a. (a, unit) t -> a =
  fun fmt -> match fmt with
    | End -> ()
    | Dig r -> fun d -> print_int d; printf r
    | Str r -> fun s -> print_string s; printf r
    | StrLit (s, r) -> print_string s; printf r

let rec sprintf0 : type a. (a, string) t -> string -> a =
  fun fmt -> fun fs ->  match fmt with
    | End -> fs
    | Dig r -> fun d -> sprintf0 r (fs ^ (string_of_int d))
    | Str r -> fun s -> sprintf0 r (fs ^ s)
    | StrLit (s, r) -> sprintf0 r (fs ^ s)

let sprintf : type a. (a, string) t -> a =
  fun fmt -> sprintf0 fmt ""

(* "Digit: %d%s" *)
let fs0 = fun r -> lit "Digit: " @@ dig @@ str r

(* fs1 : int -> string -> string *)
let fs1 = sprintf @@ to_str fs0

(*
  append format string:
  "Digit: %d%s, Digit: %d%s"
*)
let fs2 = fun r -> fs0 (lit ", " (fs0 r))

(* fs3 : int -> string -> int -> string -> string *)
let fs3 = printf (to_out fs2)

let _ =  fs3 1 "a" 2 "b\n"
