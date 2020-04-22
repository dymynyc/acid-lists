(module
  (def macs (import "./"))

  ;; TODO: macro that converts a bunch of macros to functions

  (export create (fun (a b c d) (macs.create a b c d)))

  (export set_head (fun (a b c) (macs.set_head a b c)))
  (export set_tail (fun (a b c) (macs.set_tail a b c)))

  (export is_head (fun (a b) (macs.is_head a b)))
  (export is_tail (fun (a b) (macs.is_head a b)))

  (export get_head (fun (a) (macs.get_head a)))
  (export get_tail (fun (a)
    (macs.get_tail a)
  ))

  (export len macs.len)
  (export reverse macs.reverse)

)
