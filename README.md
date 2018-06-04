# GADTFormat

Type-safe Format using GADT in OCaml

## Example

```ocaml
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

(* print: "Digit: 1a, Digit: 2b" *)
let _ =  fs3 1 "a" 2 "b\n"
```

## Licence

Distributed under the terms of [MIT License](LICENSE)

Copyright (c) 2018 noti0na1
