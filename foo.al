(module
  (def pair (import "./test"))
  (export (fun (x) (block
    (pair.head_type x 1)
    (pair.head x)
    (pair.tail_type x 1)
    (pair.tail x)
  )))
)
