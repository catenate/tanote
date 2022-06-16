# test library functions for %tanote

https://urbit.org/docs/hoon/hoon-school/libraries

## user

Rename this program.

	Edit ,s,testlib.hoon,testlib.hoon,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=testlib.md' 'file=testlib.hoon' 'variant=verbose'
lit 'lit=testlib.md' 'file=testlib.hoon'
cp testlib.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## code

Import the library for the %tanote desk.

	testlib.hoon: /+  tanote

Define a [[say generator]] that takes no arguments.

	testlib.hoon: :-  %say
	testlib.hoon: |=  *
	testlib.hoon: :-  %noun

Check return values of gates from the [[tanote library]].

### test data

Notes.

	testlib.hoon: =/  test0=note:tanote  [~ponhec-picwen "tester" ~ "test" "This is a test."]
	testlib.hoon: =/  test1=note:tanote  [~ponhec-picwen "tester" ~[~ponhec-picwen] "test" "This is a test."]
	testlib.hoon: =/  test2=note:tanote  [~ponhec-picwen "tester" ~[~ponhec-picwen ~nocsyx-lassul] "test" "This is a test."]

	testlib.hoon: =/  tagbl0=note:tanote  [~ponhec-picwen "tester" ~[~ponhec-picwen ~nocsyx-lassul] "tag and backlink" "This is a test with a #tag and a [[backlink]]."]

Histories.

	testlib.hoon: =/  history0=history:tanote  ["test" ~[test2 test1 test0]]

	testlib.hoon: =/  latest-history0=note:tanote  (snag 0 versions.history0)

### test default-tags

Test [[tanote/tanote/lib/tanote#list default tags]] to check the default tags.

	testlib.hoon:verbose: :-  (default-tags:tanote)

	testlib.hoon: :-  .=  (default-tags:tanote)
	testlib.hoon:     (sy ~["/" "*"])

### test index-tags

Test [[tanote/tanote/lib/tanote#index tags]] to find tags in a text [[tape]].

	testlib.hoon:verbose: :-  (index-tags:tanote "This is a test.")
	testlib.hoon: :-  .=  (index-tags:tanote "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (index-tags:tanote "This is a #hash test.")
	testlib.hoon: :-  .=  (index-tags:tanote "This is a #hash test.")
	testlib.hoon:     ~[10]
	testlib.hoon:verbose: :-  (index-tags:tanote "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon: :-  .=  (index-tags:tanote "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon:     ~[19 25]

### test index-backlinks

Test [[tanote/tanote/lib/tanote#index backlinks]] to find backlinks in a text [[tape]].

	testlib.hoon: :-  .=  (index-backlinks:tanote "This is a test.")
	testlib.hoon:     ~
	testlib.hoon: :-  .=  (index-backlinks:tanote "This is a [[hash]] test.")
	testlib.hoon:     ~[10]
	testlib.hoon: :-  .=  (index-backlinks:tanote "This is a multiple-[[hash]] [[~ponhec-picwen]].")
	testlib.hoon:     ~[19 28]

### test extract-tag

Test [[tanote/tanote/lib/tanote#extract tag]] to extract a tag from a text.

	testlib.hoon: :-  .=  (extract-tag:tanote 10 "This is a #hash test.")
	testlib.hoon:     "#hash"
	testlib.hoon: :-  .=  (extract-tag:tanote 19 "This is a multiple-#hash #test.")
	testlib.hoon:     "#hash"
	testlib.hoon: :-  .=  (extract-tag:tanote 25 "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon:     "~ponhec-picwen"

### test extract-tags-tape

Test [[tanote/tanote/lib/tanote#extract tags]] to extract tags from a text.

	testlib.hoon: :-  .=  (extract-tags-tape:tanote ~ "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (extract-tags-tape:tanote ~[10] "This is a #hash test.")
	testlib.hoon: :-  .=  (extract-tags-tape:tanote ~[10] "This is a #hash test.")
	testlib.hoon:     (sy ~["#hash"])
	testlib.hoon:verbose: :-  (extract-tags-tape:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon: :-  .=  (extract-tags-tape:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon:     (sy ~["#hash" "~ponhec-picwen"])

### test extract-backlink

Test [[tanote/tanote/lib/tanote#extract backlink]] to extract a backlink from a text.

	testlib.hoon: :-  .=  (extract-backlink:tanote 10 "This is a [[hash]] test.")
	testlib.hoon:     "hash"
	testlib.hoon: :-  .=  (extract-backlink:tanote 19 "This is a multiple-[[hash]] [[test]].")
	testlib.hoon:     "hash"
	testlib.hoon:verbose: :-  (extract-backlink:tanote 28 "This is a multiple-[[hash]] [[test]].")
	testlib.hoon: :-  .=  (extract-backlink:tanote 28 "This is a multiple-[[hash]] [[test]].")
	testlib.hoon:     "test"

### test extract-backlinks-tape

Test [[tanote/tanote/lib/tanote#extract backlinks]] to extract backlinks from a text.

	testlib.hoon: :-  .=  (extract-backlinks-tape:tanote ~ "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (extract-backlinks-tape:tanote ~[10] "This is a [[hash]] test.")
	testlib.hoon: :-  .=  (extract-backlinks-tape:tanote ~[10] "This is a [[hash]] test.")
	testlib.hoon:     (sy ~["hash"])
	testlib.hoon:verbose: :-  (extract-backlinks-tape:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
	testlib.hoon: :-  .=  (extract-backlinks-tape:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
	testlib.hoon:     (sy ~["link" "~ponhec-picwen"])

### test note structure

Individual notes.

	testlib.hoon:verbose: :-  test0
	testlib.hoon:verbose: :-  test1
	testlib.hoon:verbose: :-  test2

Extract each field from a note. #now 

Extract tags and backlinks from a note’s text. #now 

### test history structure

History of a note.

	testlib.hoon:verbose: :-  `history:tanote`["test" ~[test2 test1 test0]]
	testlib.hoon: :-  .=  history0
	testlib.hoon:     `history:tanote`["test" ~[test2 test1 test0]]
	testlib.hoon: :-  .=  regards.history0
	testlib.hoon:     "test"
	testlib.hoon: :-  .=  versions.history0
	testlib.hoon:     ~[test2 test1 test0]

Latest version in the history of the note.

	testlib.hoon: :-  .=  +2:versions.history0
	testlib.hoon:     test2
	testlib.hoon: :-  .=  (snag 0 versions.history0)
	testlib.hoon:     test2
	testlib.hoon: :-  .=  latest-history0
	testlib.hoon:     test2

Extract specific fields from the latest version in the history of the note.

`.` binds more tightly than `:`, so the expression `to.+2:versions.history0` fails to find `to.+2`, rather than take `to` of `+2:versions.history0`.

`to.(...)` is not valid syntax.

	testlib.hoon: :-  .=  to.latest-history0
	testlib.hoon:     ~[~ponhec-picwen ~nocsyx-lassul]

	testlib.hoon: :-  .=  by.latest-history0
	testlib.hoon:     ~ponhec-picwen
	testlib.hoon: :-  .=  as.latest-history0
	testlib.hoon:     "tester"
	testlib.hoon: :-  .=  re.latest-history0
	testlib.hoon:     "test"
	testlib.hoon: :-  .=  text.latest-history0
	testlib.hoon:     "This is a test."

Extract tags and backlinks from the latest version in a history. #now

	testlib.hoon: :-  .=  (extract-tags-tape:tanote (index-tags:tanote text.latest-history0) text.latest-history0)
	testlib.hoon:     ~
	testlib.hoon: :-  .=  (extract-backlinks-tape:tanote (index-backlinks:tanote text.latest-history0) text.latest-history0)
	testlib.hoon:     ~

	testlib.hoon: :-  .=  (extract-tags-tape:tanote (index-tags:tanote text.tagbl0) text.tagbl0)
	testlib.hoon:     (sy ~["#tag"])
	testlib.hoon: :-  .=  (extract-backlinks-tape:tanote (index-backlinks:tanote text.tagbl0) text.tagbl0)
	testlib.hoon:     (sy ~["backlink"])

_Confer_ [[2022-06-16 05-17]] discusses polymorphic gates, and whether it would be possible/better to create one function `extract-tags` which has different definitions depending on whether it gets a tape or a note.

	testlib.hoon: :-  .=  (extract-tags-note:tanote tagbl0)
	testlib.hoon:     (sy ~["#tag"])
	testlib.hoon: :-  .=  (extract-backlinks-note:tanote tagbl0)
	testlib.hoon:     (sy ~["backlink"])

### end tests

	testlib.hoon: ~

## test

Run the generator.

```hoon
+tanote!testlib
```

Output of the generator should be a list of `%.y`.

