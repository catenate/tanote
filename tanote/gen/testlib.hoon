/+  tanote
:-  %say
|=  *
:-  %noun
=/  test0=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~ "test" "This is a test."]
=/  test1=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~[~ponhec-picwen] "test" "This is a test."]
=/  test2=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~[~ponhec-picwen ~nocsyx-lassul] "test" "This is a test."]
=/  tagbl0=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~[~ponhec-picwen ~nocsyx-lassul] "tag and backlink" "This is a test with a #tag and a [[backlink]]."]
=/  test10=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~ "another test" "This is a #test with a [[backlink]]."]
=/  test11=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~[~ponhec-picwen] "another test" "This is another #test with two #tag and two [[backlink]] for [[tanote]]."]
=/  test12=note:tanote  [~ponhec-picwen "tester" [0x0 ~ponhec-picwen] ~[~ponhec-picwen ~nocsyx-lassul] "another test" "This is another #test with an #array of #tag and more [[backlink]] for [[tanote]] [[test data]]."]
=/  history0=history:tanote  ["test" ~[test2 test1 test0]]
=/  history1=history:tanote  ["another test" ~[test12 test11 test10]]
=/  latest-history0=note:tanote  (snag 0 versions.history0)
=/  store0=store:tanote  ~[history0 history1]
:-  (default-tags:tanote)
:-  .=  (default-tags:tanote)
    (sy ~["/" "*"])
:-  (index-tags:tanote "This is a test.")
:-  .=  (index-tags:tanote "This is a test.")
    ~
:-  (index-tags:tanote "This is a #hash test.")
:-  .=  (index-tags:tanote "This is a #hash test.")
    ~[10]
:-  (index-tags:tanote "This is a multiple-#hash ~ponhec-picwen.")
:-  .=  (index-tags:tanote "This is a multiple-#hash ~ponhec-picwen.")
    ~[19 25]
:-  .=  (index-backlinks:tanote "This is a test.")
    ~
:-  .=  (index-backlinks:tanote "This is a [[hash]] test.")
    ~[10]
:-  .=  (index-backlinks:tanote "This is a multiple-[[hash]] [[~ponhec-picwen]].")
    ~[19 28]
:-  .=  (extract-tag:tanote 10 "This is a #hash test.")
    "#hash"
:-  .=  (extract-tag:tanote 19 "This is a multiple-#hash #test.")
    "#hash"
:-  .=  (extract-tag:tanote 25 "This is a multiple-#hash ~ponhec-picwen.")
    "~ponhec-picwen"
:-  .=  (extract-tags-tape:tanote ~ "This is a test.")
    ~
:-  (extract-tags-tape:tanote ~[10] "This is a #hash test.")
:-  .=  (extract-tags-tape:tanote ~[10] "This is a #hash test.")
    (sy ~["#hash"])
:-  (extract-tags-tape:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
:-  .=  (extract-tags-tape:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
    (sy ~["#hash" "~ponhec-picwen"])
:-  .=  (extract-backlink:tanote 10 "This is a [[hash]] test.")
    "hash"
:-  .=  (extract-backlink:tanote 19 "This is a multiple-[[hash]] [[test]].")
    "hash"
:-  (extract-backlink:tanote 28 "This is a multiple-[[hash]] [[test]].")
:-  .=  (extract-backlink:tanote 28 "This is a multiple-[[hash]] [[test]].")
    "test"
:-  .=  (extract-backlinks-tape:tanote ~ "This is a test.")
    ~
:-  (extract-backlinks-tape:tanote ~[10] "This is a [[hash]] test.")
:-  .=  (extract-backlinks-tape:tanote ~[10] "This is a [[hash]] test.")
    (sy ~["hash"])
:-  (extract-backlinks-tape:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
:-  .=  (extract-backlinks-tape:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
    (sy ~["link" "~ponhec-picwen"])
:-  test0
:-  test1
:-  test2
:-  `history:tanote`["test" ~[test2 test1 test0]]
:-  .=  history0
    `history:tanote`["test" ~[test2 test1 test0]]
:-  .=  regards.history0
    "test"
:-  .=  versions.history0
    ~[test2 test1 test0]
:-  .=  +2:versions.history0
    test2
:-  .=  (snag 0 versions.history0)
    test2
:-  .=  latest-history0
    test2
:-  .=  to.latest-history0
    ~[~ponhec-picwen ~nocsyx-lassul]
:-  .=  by.latest-history0
    ~ponhec-picwen
:-  .=  as.latest-history0
    "tester"
:-  .=  if.latest-history0
    [0x0 ~ponhec-picwen]
:-  .=  re.latest-history0
    "test"
:-  .=  text.latest-history0
    "This is a test."
:-  .=  (extract-tags-tape:tanote (index-tags:tanote text.latest-history0) text.latest-history0)
    ~
:-  .=  (extract-backlinks-tape:tanote (index-backlinks:tanote text.latest-history0) text.latest-history0)
    ~
:-  .=  (extract-tags-tape:tanote (index-tags:tanote text.tagbl0) text.tagbl0)
    (sy ~["#tag"])
:-  .=  (extract-backlinks-tape:tanote (index-backlinks:tanote text.tagbl0) text.tagbl0)
    (sy ~["backlink"])
:-  .=  (extract-tags-note:tanote tagbl0)
    (sy ~["#tag"])
:-  .=  (extract-backlinks-note:tanote tagbl0)
    (sy ~["backlink"])
:-  .=  (extract-tags-history:tanote history0)
    ~
:-  .=  (extract-backlinks-history:tanote history0)
    ~
:-  .=  (extract-tags-history:tanote history1)
    (sy ~["#array" "#tag" "#test"])
:-  .=  (extract-backlinks-history:tanote history1)
    (sy ~["backlink" "tanote" "test data"])
:-  store0
:-  .=  (extract-tags-store:tanote store0)
    (sy ~["#array" "#tag" "#test"])
:-  .=  (extract-backlinks-store:tanote store0)
    (sy ~["backlink" "tanote" "test data"])
~
:: DO NOT EDIT THIS FILE.  Auto-generated from verbose testlib.md by lit.
