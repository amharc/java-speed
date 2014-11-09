open Scanf

type 'a heap = Empty | Heap of 'a * 'a heap list

let link h1 h2 = match h1, h2 with
  | Empty, heap -> heap
  | heap, Empty -> heap
  | Heap (k1, c1), Heap (k2, c2) when k1 < k2 ->
      Heap (k1, h2 :: c1)
  | Heap (k1, c1), Heap (k2, c2) ->
      Heap (k2, h1 :: c2);;

let rec merge heap = match heap with
  | [] -> Empty
  | [heap] -> heap
  | h1 :: h2 :: hs -> link (link h1 h2) (merge hs);;

let makeheap key = Heap (key, []);;

let top heap = match heap with
  | Empty -> failwith "Empty heap"
  | Heap (key, _) -> key;;

let pop heap = match heap with
  | Empty -> failwith "Empty heap"
  | Heap (_, chld) -> merge chld;;

let insert heap key = link heap (makeheap key);;

let rec process rheap =
  scanf "%d" (fun mode ->
    match mode with
      | 0 -> scanf " %d\n" (fun key ->
              rheap := insert !rheap key)
      | 1 -> scanf "\n" ignore; print_endline (string_of_int (top !rheap))
      | 2 -> scanf "\n" ignore; rheap := pop !rheap);
  process rheap;;

try
  process (ref Empty)
with End_of_file -> ();;
