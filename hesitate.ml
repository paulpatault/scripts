#!/home/trotski/.opam/default/bin/ocaml

let () = Random.self_init ()

let () =
  try
    let t = Sys.argv in
    let i = Random.int (Array.length t - 1) in
    Format.printf "result: %s@." t.(i+1)
  with _ ->
    Format.printf "usage: hesitate choice_1 ... choice_n@."
