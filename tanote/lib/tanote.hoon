|%
++  default-tags
  |=  ~
  ^-  (list @t)
  ~['*' '/']
++  extract-tag
  |=  [oi=@ud text=(list @t)]
  =/  max=@  (lent text)
  =/  allowed=(list @t)  "#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  =/  tag=(list @t)  ~
  |-
  ^-  (list @t)
  ?:  =(oi max)
    (flop tag)
  =/  t=@t  (snag oi text)
  ?:  =(~ (find ~[t] allowed))
    (flop tag)
  $(oi +(oi), tag [t tag])
++  extract-tags
  |=  [ois=(list @ud) text=(list @t)]
  =/  tags=(list)  ~
  |-
  ^-  (list)
  ?:  =(~ ois)
    (flop tags)
  $(ois +3:ois, tags [(extract-tag +2:ois text) tags])
++  octothorpe-indices
  |=  text=(list @t)
  (fand "#" text)
--
:: DO NOT EDIT THIS FILE.  Auto-generated from default tanote.md by lit.