# documentation and help for %tanote

Formatted as tanote notes.

## use this file

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

## test

Run the generator.

```hoon
+tanote!help
```

Output of the generator should be a list of `%.y`.  If we extracted the verbose variant, then the list will also contain various tanote structures.

## generator header

Import the library for the %tanote desk.

	help.hoon: /+  tanote

Define a [[say generator]] that takes no arguments.

	help.hoon: :-  %say
	help.hoon: |=  *
	help.hoon: :-  %noun

Check return values of gates from the [[tanote library]].

## test data

### about note

	help.hoon: =/  note0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "note" "A note is composed of several #field: by, as, if, to, re, and text."]

Rather than defining a history, add the given note to an empty history.

	help.hoon: =/  note-history=history:tanote  (add-note-history:tanote note0 ["note" ~])

### about history

An initial text.

	help.hoon: =/  history0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "history" "A history is a list of notes, with the latest note first; and a regards, which is the same as the re #field of each note."]

Rather than defining a history, add the given note to an empty history.

	help.hoon: =/  history-history=history:tanote  (add-note-history:tanote history0 ["history" ~])

An updated text.

	help.hoon: =/  history1=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "history" "A [[history]] is a #list of notes, with the latest [[note]] first; and a [[regards]], which a #tape (text string) that is the same as the [[re]] field of each [[note]]."]

Update the history of the history note.

	help.hoon: =/  updated-history-history=history:tanote  (add-note-history:tanote history1 history-history)

### about store

	help.hoon: =/  store0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "store" "A store is a list of histories."]

Rather than defining a history, add the given note to an empty history.

	help.hoon: =/  store-history=history:tanote  (add-note-history:tanote store0 ["store" ~])

### store of help

Rather than defining a store, add notes to an initially-empty store.

	help.hoon: =/  help0=store:tanote  (add-note-store:tanote note0 (add-note-store:tanote history0 (add-note-store:tanote store0 ~)))
	help.hoon: =/  help1=store:tanote  (add-note-store:tanote history1 help0)

### front of help

Create a default front with all the histories.

	help.hoon: =/  all0=front:tanote  [tab="default" tags=~ tugs=~ regards=~ histories=help0]
	help.hoon: =/  all1=front:tanote  [tab="default" tags=~ tugs=~ regards=~ histories=help1]

Filter by regards: contain only the note with the selected regards, and notes with backlinks to the selected regards.  In the front end, selecting (clicking on) a regards also presents the latest version of that note in the third (lower) section.  Pass in to `filter-front` a front with the filter criteria and the default store, and get back a front with a filtered store.  `Filter-front` filters by all the set criteria.

	help.hoon: =/  filter-regards0=front:tanote  (filter-front-regards:tanote [tab="histories" tags=~ tugs=~ regards="history" histories=help0])

Filter by tags (system tags): contain only notes with the selected system tags in the latest version.

	help.hoon:notyet: =/  filter-unseen0=front:tanote  (filter-front:tanote [tab="unseen" tags=(sy ~["#unseen"]) tugs=~ regards=~ histories=help0])

Filter by tugs (user tags): contain only notes with the selected user tags in the latest version.

	help.hoon: =/  filter-field1=front:tanote  (filter-front-tugs:tanote [tab="field" tags=~ tugs=(sy ~["#field"]) regards=~ histories=help1])

## initial text

### test history structure

	help.hoon: :-  =(note-history ["note" ~[note0]])
	help.hoon: :-  =(history-history ["history" ~[history0]])
	help.hoon: :-  =(store-history ["store" ~[store0]])

### test store structure

A store of histories.

	help.hoon:verbose: :-  help0
	help.hoon: :-  .=  help0

Updating the store flops it.

	help.hoon:     ~[note-history history-history store-history]
	help.hoon: :-  .=  (extract-tags-store:tanote help0)
	help.hoon:     (sy ~["#field"])
	help.hoon: :-  .=  (extract-backlinks-store:tanote help0)
	help.hoon:     (sy ~["reviewer"])

Filter store by a tag.

	help.hoon:verbose: :-  (filter-store-tag:tanote help0 "#field")
	help.hoon: :-  .=  (filter-store-tag:tanote help0 "#field")
	help.hoon:     ~[history-history note-history]
	help.hoon:verbose: :-  (find-store-regards:tanote help0 "history")
	help.hoon: :-  .=  (find-store-regards:tanote help0 "history")
	help.hoon:     history-history

## add new version of note to store

### test history structure

	help.hoon: :-  =(updated-history-history ["history" ~[history1 history0]])

### test store structure

A store of histories.

	help.hoon:verbose: :-  help1
	help.hoon: :-  .=  help1
	help.hoon:     ~[store-history updated-history-history note-history]
	help.hoon: :-  .=  (extract-tags-store:tanote help1)
	help.hoon:     (sy ~["#field" "#list" "#tape"])
	help.hoon: :-  .=  (extract-backlinks-store:tanote help1)
	help.hoon:     (sy ~["reviewer" "history" "note" "regards" "re" "note"])

Filter store by a tag.

	help.hoon:verbose: :-  (filter-store-tag:tanote help1 "#field")
	help.hoon: :-  .=  (filter-store-tag:tanote help1 "#field")
	help.hoon:     ~[note-history]
	help.hoon:verbose: :-  (find-store-regards:tanote help1 "history")
	help.hoon: :-  .=  (find-store-regards:tanote help1 "history")
	help.hoon:     updated-history-history

## displays

### display tags

	help.hoon:verbose: :-  (display-tags:tanote help0)
	help.hoon: :-  .=  (display-tags:tanote help0)
	help.hoon:     (sy ~["*" "/" "#field"])

	help.hoon:verbose: :-  (display-tags:tanote help1)
	help.hoon: :-  .=  (display-tags:tanote help1)
	help.hoon:     (sy ~["*" "/" "#field" "#list" "#tape"])

### display backlinks

	help.hoon:verbose: :-  (display-backlinks:tanote help0)
	help.hoon: :-  .=  (display-backlinks:tanote help0)
	help.hoon:     (sy ~["reviewer"])

	help.hoon:verbose: :-  (display-backlinks:tanote help1)
	help.hoon: :-  .=  (display-backlinks:tanote help1)
	help.hoon:     (sy ~["reviewer" "history" "note" "regards" "re" "note"])

### display all regards

	help.hoon:verbose: :-  (list-regards-store:tanote help0)
	help.hoon: :-  .=  (list-regards-store:tanote help0)
	help.hoon:     ~["store" "history" "note"]

### display selected regards from a front

List all regards from the store of the default front.

	help.hoon:verbose: :-  all0
	help.hoon: :-  .=  histories.all0
	help.hoon:     help0
	help.hoon: :-  .=  (list-regards-store:tanote histories.all0)
	help.hoon:     ~["store" "history" "note"]

	help.hoon:verbose: :-  all1
	help.hoon: :-  .=  histories.all1
	help.hoon:     help1

We should not rely on the notes being an any particular order.  Which means that if we want to print them in alphabetical order in the front end, we’ll have to sort them just before presentation (_eg_, in `display-regards`).

	help.hoon: :-  .=  (list-regards-store:tanote histories.all1)
	help.hoon:     ~["note" "history" "store"]

List all regards from the store of a front with selections.

	help.hoon:verbose: :-  filter-regards0
	help.hoon: :-  .=  filter-regards0
	help.hoon:     [tab="histories" tags=~ tugs=~ regards="history" histories=~[history-history]]

Is it calm to be told constantly that you need to catch up with what has been sent by others to your store?  If not, just don’t have the system tag “#unseen”, and let people find new stuff as they intentionally explore their own store.

	help.hoon:verbose:notyet: :-  filter-unseen0

	help.hoon:verbose: :-  filter-field1

## end tests

	help.hoon: ~
