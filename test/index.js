var tape = require('tape')
var lists = require('acidlisp/require')(__dirname)('../funs')

console.log(lists)

function cons (s, x, t, y) {
  return lists.create(s, x, t, y)
}

function length (l) {
  if(!lists.get_tail(l)) return 1
  else return length(lists.get_tail(l)) + 1
}

tape('basics', function (t) {
  var v = lists.create(0, 0, 0, 0)
  t.notEqual(v, 0)
  var a = cons(0, 0, 1, cons(0, 0, 1, cons(0, 0)))
  t.equal(length(a), 3)
  t.equal(lists.len(a), 3)
  t.end()
})


function toString(l) {
  var s = '('
  while(l) {
    if(lists.is_head(l, 0))
      s += 'nil '
    else if(lists.is_head(l, 1))
      s += toString(lists.get_head(l)) + ' '
    else if(lists.is_head(l, 2))
      s += lists.get_head(l) + ' '
    else
      throw new Error('type not supported')
    l = lists.get_tail(l)
  }
  return s.trim() +')'
}
tape('reverse', function (t) {
  var a = cons(2, 10, 1, cons(2, 20, 1, cons(2, 30, 0, 0)))
  t.notEqual(v, 0)
  t.equal(length(a), 3)
  t.equal(lists.len(a), 3)

  t.equal(lists.get_head(a), 10)
  t.equal(lists.get_head(lists.get_tail(a)), 20)
  t.equal(lists.get_head(lists.get_tail(lists.get_tail(a))), 30)


  t.equal(toString(a), '(10 20 30)')
  return t.end()

  var v = lists.reverse(a)
  t.equal(lists.get_head(a), 3)
  t.equal(lists.get_head(lists.get_tail(a)), 2)
  t.equal(lists.get_head(lists.get_tail(lists.get_tail(a))), 1)

  t.equal(toString(v), '(30 20 10)')

  t.end()
})

tape('tree', function (t) {
  var a = cons(
          1, cons(2, 100, 1, cons(2, 200, 0, 0)),
          1, cons(2, 20, 1, cons(2, 30, 0, 0)))
  t.equal(toString(a), '((100 200) 20 30)')
  t.equal(toString(lists.create(0,0,0,0)), '(nil)')
  //in the classic lisp way, null pointer is empty list.
  //if you concat with it, you get a list.
  t.equal(toString(0), '()')

  t.end()
})
