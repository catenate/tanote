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

Check the default tags.

	testlib.hoon:verbose: :-  (default-tags:tanote)

	testlib.hoon: :-  .=  (default-tags:tanote)
	testlib.hoon:     (sy ~["/" "*"])

Find tags in a text [[tape]].

	testlib.hoon: :-  .=  (octothorpe-indices:tanote "This is a test.")
	testlib.hoon:     ~
	testlib.hoon: :-  .=  (octothorpe-indices:tanote "This is a #hash test.")
	testlib.hoon:     ~[10]
	testlib.hoon: :-  .=  (octothorpe-indices:tanote "This is a multiple-#hash #test.")
	testlib.hoon:     ~[19 25]

Extract a tags from a text.

	testlib.hoon: :-  .=  (extract-tag:tanote 10 "This is a #hash test.")
	testlib.hoon:     "#hash"
	testlib.hoon: :-  .=  (extract-tag:tanote 19 "This is a multiple-#hash #test.")
	testlib.hoon:     "#hash"
	testlib.hoon: :-  .=  (extract-tag:tanote 25 "This is a multiple-#hash #test.")
	testlib.hoon:     "#test"

Extract tags from text.

	testlib.hoon: :-  .=  (extract-tags:tanote ~ "This is a test.")
	testlib.hoon:     ~
	testlib.hoon:verbose: :-  (extract-tags:tanote ~[10] "This is a #hash test.")
	testlib.hoon: :-  .=  (extract-tags:tanote ~[10] "This is a #hash test.")
	testlib.hoon:     (sy ~["#hash"])
	testlib.hoonverbose:: :-  (extract-tags:tanote ~[19 25] "This is a multiple-#hash #test.")
	testlib.hoon: :-  .=  (extract-tags:tanote ~[19 25] "This is a multiple-#hash #test.")
	testlib.hoon:     (sy ~["#hash" "#test"])

End tests.

	testlib.hoon: ~

## test

Run the generator.

```hoon
+tanote!testlib
```

Output of the generator should be a list of `%.y`.

