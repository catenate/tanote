# documentation and help for %tanote

Formatted as tanote notes.
## user

Rename this program.

	Edit ,s,help.hoon,help.hoon,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=help.md' 'file=help.hoon' 'variant=verbose'
lit 'lit=help.md' 'file=help.hoon'
cp help.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## code

Import the library for the %tanote desk.

	help.hoon: /+  tanote

Define a [[say generator]] that takes no arguments.

	help.hoon: :-  %say
	help.hoon: |=  *
	help.hoon: :-  %noun

Check return values of gates from the [[tanote library]].

### test data

#### about note

	help.hoon: =/  note0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "note" "A note is composed of several #field: by, as, if, to, re, and text."]
	help.hoon: =/  note-history=history:tanote  ["note" ~[note0]]

#### about history

	help.hoon: =/  history0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "history" "A history is a list of notes, with the latest note first; and a regards, which is the same as the re #field of each note."]
	help.hoon: =/  history-history=history:tanote  ["history" ~[history0]]

#### about store

	help.hoon: =/  store0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "store" "A store is a list of histories."]
	help.hoon: =/  store-history=history:tanote  ["store" ~[store0]]

#### store of help

	help.hoon: =/  store-help=store:tanote  ~[note-history history-history store-history]

### test store structure

A store of histories.

	help.hoon:verbose: :-  store-help
	help.hoon: :-  .=  (extract-tags-store:tanote store-help)
	help.hoon:     (sy ~["#field"])
	help.hoon: :-  .=  (extract-backlinks-store:tanote store-help)
	help.hoon:     ~

Filter store by a tag.

	help.hoon:verbose: :-  (filter-store-tag:tanote store-help "#field")
	help.hoon: :-  .=  (filter-store-tag:tanote store-help "#field")
	help.hoon:     ~[history-history note-history]
	help.hoon:verbose: :-  (find-store-regards:tanote store-help "store")
	help.hoon: :-  .=  (find-store-regards:tanote store-help "store")
	help.hoon:     store-history

### end tests

	help.hoon: ~

## test

Run the generator.

```hoon
+tanote!help
```

Output of the generator should be a list of `%.y`.  If we extracted the verbose variant, then the list will also contain various tanote structures.
