type ('a, 'b) t =
  | End : ('a, 'a) t
  | Dig : ('a, 'b) t -> (int -> 'a, 'b) t
  | Str : ('a, 'b) t -> (string -> 'a, 'b) t
  | StrLit : string * ('a, 'b) t -> ('a, 'b) t

let dig r = Dig r

let str r = Str r

let lit s r = StrLit (s, r)

(* let (@&) f g a = f (g a) *)

let to_out f : ('a, unit) t = f End

let to_str f : ('a, string) t = f End

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
