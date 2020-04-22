(module
  (def mem (import "acid-memory"))

  ;; returns the head (consistent with other set functions)
  (def set_head (mac (p type_id value) &{block
    (i32_store        $p  $type_id)
    (i32_store (add 4 $p) $value)
  }))

  ;; returns the tail (consistent with other set functions)
  (def set_tail (mac (p type_id value) &{block
    (i32_store (add  8 $p) $type_id)
    (i32_store (add 12 $p) $value)
  }))

  (export create (mac (type_a a type_b b) &{block
    (def p (mem.alloc 16))
    (set_head p $type_a $a)
    (set_tail p $type_b $b)
    p
  }))

  (export set_head set_head)
  (export set_tail set_tail)

  ;;check that the head has an expected type
  (def is_head (mac (p type_id)
    &(eq (i32_load        $p)  $type_id)))
  (def is_tail (mac (p type_id)
    &(eq (i32_load (add 8 $p)) $type_id)))

  (def get_head (mac (p) &(i32_load (add  4 $p)) ))
  (def get_tail (mac (p) &(i32_load (add 12 $p)) ))

  (export is_head  is_head)
  (export is_tail  is_tail)
  (export get_head get_head)
  (export get_tail get_tail)

  (export len (fun (l)
    (if l (add 1 (len (get_tail l))) 0)
  ))

  (export reverse (fun (l) (block
    (def n 0)
    (def e 0)
    (loop l
      (block
        ;;fail, unless we are reversing a list.
        ;;(if (or (eq 0 (get_tail l)) (is_tail l 1)) 0 (fatal))
        (set n (get_tail l))
        (set_tail l (if e 1 0) e)
        (set e l)
        (set l n)
      )
    )
    e
  )))

  ;;build tree
  ;; add_leaf
  ;; add_branch
  ;; close_branch
  ;; 
  ;; build a tree in reverse, with a pointer to the last added node.
  ;; add a node by

  ;; add a leaf by creating a cons that links back to previous leaf
  ;;(export add_leaf (fun (tree item_type item)
  ;;  (create item_type item 1 tree)
  ;;))
  ;; add a branch by 
  ;;(export add_branch (fun (tree item_type item)
  ;;  (create item_type item 1 (create 1 tree 0 0))
  ;;))


)
