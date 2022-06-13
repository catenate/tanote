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

### test extract-tags

Test [[tanote/tanote/lib/tanote#extract tags]] to extract tags from a text.

	testlib.hoon: :-  .=  (extract-tags:tanote ~ "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (extract-tags:tanote ~[10] "This is a #hash test.")
	testlib.hoon: :-  .=  (extract-tags:tanote ~[10] "This is a #hash test.")
	testlib.hoon:     (sy ~["#hash"])
	testlib.hoon:verbose: :-  (extract-tags:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
	testlib.hoon: :-  .=  (extract-tags:tanote ~[19 25] "This is a multiple-#hash ~ponhec-picwen.")
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

### test extract-backlinks

Test [[tanote/tanote/lib/tanote#extract backlinks]] to extract backlinks from a text.

	testlib.hoon: :-  .=  (extract-backlinks:tanote ~ "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (extract-backlinks:tanote ~[10] "This is a [[hash]] test.")
	testlib.hoon: :-  .=  (extract-backlinks:tanote ~[10] "This is a [[hash]] test.")
	testlib.hoon:     (sy ~["hash"])
	testlib.hoon:verbose: :-  (extract-backlinks:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
	testlib.hoon: :-  .=  (extract-backlinks:tanote ~[19 28] "This is a multiple-[[link]] [[~ponhec-picwen]].")
	testlib.hoon:     (sy ~["link" "~ponhec-picwen"])

End tests.

	testlib.hoon: ~

## test

Run the generator.

```hoon
+tanote!testlib
```

Output of the generator should be a list of `%.y`.

