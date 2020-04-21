(module

;;  (def i32 [list
;;    &size : 4
;;    &get  : [mac (p)   &{i32_load  $p   }]
;;    &set  : [mac (p v) &{i32_store $p $v}]
;;  ])

  (def field (fun (offset)
    (if (eq 0 offset)
      [mac (ptr) &{i32_load $ptr}]
      [mac (ptr) &{i32_load (add $ptr $offset)}]
    )
  ))

  (def struct (mac (field_list) (block
    (def out [list &list])
    (def offset 0)
    (loop (eq 0 (is_empty field_list))
      (block
        (def name (head (head field_list)))
        (set out (cat out
          [list [list &list
            [list &quote name]
;;            [field offset]
          ]]))
        (set offset (add offset (head (tail (head field_list)))))
        (set field_list (tail field_list))
      ))
    out
  )))

  (def pair (struct (
    head_type : 4
    head      : 4
    tail_type : 4
    tail      : 4
  )))

  (export (fun (x) {block
    (pair.head_type x)
    (pair.head      x)
    (pair.tail_type x)
    (pair.tail      x)
  }))

)
