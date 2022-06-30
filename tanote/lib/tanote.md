# library functions for %tanote

https://urbit.org/docs/hoon/hoon-school/libraries

## use this file

Rename this program.

	Edit ,s,tanote,tanote,g

List arms.

	grep -n '^\+\+ ' tanote.hoon /dev/null

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=tanote.md' 'file=tanote.hoon'
cp tanote.hoon /n/local/home/jdc/urbit/zod/tanote/lib/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## data structures

Include the gora library, to define the type of a gora id?  Or is it just a `@ud`?

Define a core.

	tanote.hoon: |%

### note structure

The rune `+$` ([[lusbuc]]) defines a structure arm (type definition).

	tanote.hoon: +$  note  [by=@p as=tape if=[@ux @p] to=(list @p) re=tape text=tape]

### history structure

	tanote.hoon: +$  history  [regards=tape versions=(list note)]

### store structure

	tanote.hoon: +$  store  (list history)

## add note versions

### add note to a history

`h=history  (add-note-history)`: Given a new note and a history, check whether the `re` of the note matches the `regards` of the history.   If so, prepend the note to the `versions` of the history as the first (latest) version of the note.

Define the arm.

	tanote.hoon: ++  add-note-history

Accept a note and a history.

	tanote.hoon:   |=  [n=note h=history]

Return a history.

	tanote.hoon:   ^-  history

Check whether the `re` of the note version matches the `regards` of the history.

	tanote.hoon:   ?:  =(regards.h re.n)

If there are no versions in the history, then return the history with only the note.

	tanote.hoon:     ?~  versions.h
	tanote.hoon:       [regards.h ~[n]]

Return the history with the given note version prepended.

	tanote.hoon:     [regards.h [n versions.h]]

If the `re` of the note version does not match the `regards` of the history, return a new history with the given note.

	tanote.hoon:   [re.n ~[n]]

### add a note to a store 

`s=store  (add-note-store note store)`: Given a new note and a store, find the history of the note in the store.  If the new note's `re` is not already in the store as a `regards` of any history, then add a new history with the note, and set its `regards` to the new note's `re`.  If the new note's `re` is already a regards in the store, then use `add-note-history` to add the new note as the latest (first) version in the history's `versions`.

Work through the given store, building another store with either the updated history, or a new history.

Define the arm.

	tanote.hoon: ++  add-note-store

Accept a note and a store.

	tanote.hoon:   |=  [n=note s0=store]

If the note is not in the store, add a history for the note and return the updated store.

	tanote.hoon:   =/  found=history  (find-store-regards s0 re.n)
	tanote.hoon:   ?:  =(found [re.n ~])
	tanote.hoon:     [[re.n ~[n]] s0]

Build an updated store.

	tanote.hoon:   =/  s1=store  ~

Recursion point.

	tanote.hoon:   |-

Return a store.

	tanote.hoon:   ^-  store

When the given store is empty, return the built store.  If we haven't yet added in the note, we should do so now.

	tanote.hoon:   ?~  s0
	tanote.hoon:     s1

Check the first history in the store

	tanote.hoon:   =/  h0=history  +2:s0

If the first history in the store matches, update the history with the note, and continue.

	tanote.hoon:   ?:  =(re.n regards.h0)
	tanote.hoon:     $(s0 +3:s0, s1 [[regards.h0 [n versions.h0]] s1])

Otherwise, just continue with the next history.

	tanote.hoon:   $(s0 +3:s0, s1 [h0 s1])

## defaults

### default tags

Define the arm.

	tanote.hoon: ++  default-tags

Define the gate with no parameters.

	tanote.hoon:   |=  ~

We return a [[set of tapes]].

	tanote.hoon:   ^-  (set tape)

`*` means all notes.  `/` means select notes with backlinks to the selected note.

	tanote.hoon:   (sy ~["*" "/"])

## generate displays

### display tags

Define the arm.

	tanote.hoon: ++  display-tags

Accept a store.

	tanote.hoon:   |=  s=store

Return a set of tags.

	tanote.hoon:   ^-  (set tape)

Unite the default tags with the tags in the store.

	tanote.hoon:   (~(uni in (default-tags)) (extract-tags-store s))

### display visible backlinks

Define the arm.

	tanote.hoon: ++  display-backlinks

Accept a store.

	tanote.hoon:   |=  s=store

Return a set of tags.

	tanote.hoon:   ^-  (set tape)

Unite the default tags with the tags in the store.

	tanote.hoon:   (extract-backlinks-store s)

## extract backlinks

### extract backlink

Extract a [[tanote/glossary#backlink]] from a [[tanote/glossary#text]].

	tanote.hoon: ++  extract-backlink

Accept the index of opening brackets, and the text.

	tanote.hoon:   |=  [start=@ud text=tape]

Start looking for the backlink text after the opening brackets (`[[`).

	tanote.hoon:   =/  cursor=@ud  (add 2 start)

Figure out when to stop looking for a space.

	tanote.hoon:   =/  max=@ud  (lent text)

Build up the substring.

	tanote.hoon:   =/  backlink=tape  ~

Recursion point.

	tanote.hoon:   |-

Return a tape.

	tanote.hoon:   ^-  tape

If we are too close to the end of the tape, stop, and invalidate the backlink.  This means that the opening brackets were not closed by closing brackets (`]]`).

	tanote.hoon:   ?:  =(cursor (dec max))
	tanote.hoon:     ~

Grab the current character.

	tanote.hoon:   =/  t0=@t  (snag cursor text)
	tanote.hoon:   =/  t1=@t  (snag +(cursor) text)

If we find the closing brackets, stop, and return the backlink.

	tanote.hoon:   ?:  =(~[t0 t1] "]]")
	tanote.hoon:     (flop backlink)

Otherwise, build up the backlink with the next character.

	tanote.hoon:   $(cursor +(cursor), backlink [t0 backlink])

### extract backlinks from a history

Extract [[tanote/glossary#backlink]]s from a note history.

	tanote.hoon: ++  extract-backlinks-history

Accept a note history, and consider only the latest (first) note.

	tanote.hoon:   |=  h=history
	tanote.hoon:   (extract-backlinks-note (snag 0 versions.h))

### extract backlinks from a note

Extract [[tanote/glossary#backlink]]s from a note.

	tanote.hoon: ++  extract-backlinks-note

Accept a note, and determine the list of backlink indices and the text of the note.

	tanote.hoon:   |=  n=note

Return a set of backlinks.

	tanote.hoon:   ^-  (set tape)

Construct a set of all tags in the note text, and add metadata backlinks from [[tanote/glossary#as]].  #now 

	tanote.hoon:   (~(uni in (sy ~[as.n])) (extract-backlinks-tape (index-backlinks text.n) text.n))

### extract backlinks from a store 

Extract [[tanote/glossary#backlink]]s from a store.

	tanote.hoon: ++  extract-backlinks-store

Accept a store, and compose the set of backlinks from all the histories.

	tanote.hoon:   |=  s=store

Build up a set of backlinks.

	tanote.hoon:   =/  backlinks=(set tape)  ~

Recursion point.

	tanote.hoon:   |-

Return a set of backlinks.

	tanote.hoon:   ^-  (set tape)

When we are done processing histories, return the set of backlinks.

	tanote.hoon:   ?~  s
	tanote.hoon:     backlinks

Extract backlinks from the first history, take the union of these and the set we are building, and then recurse with the remainder of the store.

	tanote.hoon:   $(s +3:s, backlinks (~(uni in backlinks) (extract-backlinks-history +2:s)))

### extract backlinks from a tape

Extract [[tanote/glossary#backlink]]s from note [[tanote/glossary#text]].

	tanote.hoon: ++  extract-backlinks-tape

Accept the list of backlink starts, and the text of the note.

	tanote.hoon:   |=  [starts=(list @ud) text=tape]

Build up the set of backlinks.

	tanote.hoon:   =/  backlinks=(set tape)  ~

Recursion point.

	tanote.hoon:   |-

Return a set of tapes.

	tanote.hoon:   ^-  (set tape)

Once we're done with the list of starting indices, return the set of backlinks.

	tanote.hoon:   ?~  starts
	tanote.hoon:     backlinks

For each starting index, extract the backlink at that index from the text, and add it to the set of backlinks.

	tanote.hoon:   $(starts +3:starts, backlinks (~(put in backlinks) (extract-backlink +2:starts text)))

## extract tags

### extract tag

Extract a [[tanote/glossary#tag]] from a [[tanote/glossary#text]].

	tanote.hoon: ++  extract-tag

Accept a tag index, and the text.

	tanote.hoon:   |=  [oi=@ud text=tape]

Figure out when to stop looking for a space.

	tanote.hoon:   =/  max=@  (lent text)

For [[tanote/glossary#tag]]s, we want to accept alphanumeric strings following an octothorpe (_eg_ `#test`) as well as the `@p`s (_eg_ `~ponhec-picwen`) of authors ([[tanote/glossary#by]]) and recipients ([[tanote/glossary#to]]).

	tanote.hoon:   =/  allowed=tape  "#-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~"

Build up the substring.

	tanote.hoon:   =/  tag=tape  ~

Recursion point.

	tanote.hoon:   |-

Return a tape.

	tanote.hoon:   ^-  tape

If we are at the string length, stop, and return the tag.

	tanote.hoon:   ?:  =(oi max)
	tanote.hoon:     (flop tag)

Grab the current character.

	tanote.hoon:   =/  t=@t  (snag oi text)

If we are at a character that is not part of a hash, stop, and return the tag.

	tanote.hoon:   ?~  (find ~[t] allowed)
	tanote.hoon:     (flop tag)

Otherwise, build up the tag with the next character.

	tanote.hoon:   $(oi +(oi), tag [t tag])

### extract tags from a history

Extract [[tanote/glossary#tag]]s from a note history.

	tanote.hoon: ++  extract-tags-history

Accept a note history, and consider only the latest (first) note.

	tanote.hoon:   |=  h=history
	tanote.hoon:   (extract-tags-note (snag 0 versions.h))

### extract tags from a note

Extract [[tanote/glossary#tag]]s from a note.

	tanote.hoon: ++  extract-tags-note

Accept a note, and determine the list of tag indices and the text of the note.

	tanote.hoon:   |=  n=note

Return a set of tags.

	tanote.hoon:   ^-  (set tape)

Construct a set of all tags in the note text, and add metadata tags from @p. #now 

	tanote.hoon:   (extract-tags-tape (index-tags text.n) text.n)

### extract tags from a store 

Extract [[tanote/glossary#tag]]s from a store.

	tanote.hoon: ++  extract-tags-store

Accept a store, and compose the set of tags from all the histories.

	tanote.hoon:   |=  s=store

Build up a set of tags.

	tanote.hoon:   =/  tags=(set tape)  ~

Recursion point.

	tanote.hoon:   |-

Return a set of tags.

	tanote.hoon:   ^-  (set tape)

When we are done processing histories, return the set of tags.

	tanote.hoon:   ?~  s
	tanote.hoon:     tags

Extract tags from the first history, take the union of these and the set we are building, and then recurse with the remainder of the store.

	tanote.hoon:   $(s +3:s, tags (~(uni in tags) (extract-tags-history +2:s)))

### extract tags from a tape

Extract [[tanote/glossary#tag]]s from note [[tanote/glossary#text]].

	tanote.hoon: ++  extract-tags-tape

Accept the list of tag indices, and the text of the note.

	tanote.hoon:   |=  [starts=(list @ud) text=tape]

Build up the set of tags.

	tanote.hoon:   =/  tags=(set tape)  ~

Recursion point.

	tanote.hoon:   |-

Return a set of tapes.

	tanote.hoon:   ^-  (set tape)

Once we're done with the list of tag indices, return the set of tags.

	tanote.hoon:   ?~  starts
	tanote.hoon:     tags

For each tag index, extract the tag at that index from the text, and add it to the set of tags.

	tanote.hoon:   $(starts +3:starts, tags (~(put in tags) (extract-tag +2:starts text)))

## find in stores

### find-store-regards

Given a store and a regards, return the history with the given regards.

	tanote.hoon: ++  find-store-regards

Accept a store, and the regards to find.

	tanote.hoon:   |=  [s=store regards=tape]

Recursion point.

	tanote.hoon:   |-

Return a store.

	tanote.hoon:   ^-  history

Once we're done with the store, return an empty history with the given regards, to use as a new history.

	tanote.hoon:   ?~  s
	tanote.hoon:     [regards ~]

Check whether this history has the given regards.

	tanote.hoon:   =/  h=history  +2:s
	tanote.hoon:   ?:  =(regards.h regards)
	tanote.hoon:     h

Otherwise, continue with the rest of the store.

	tanote.hoon:   $(s +3:s)

### filter-store-tag

Given a store and a tag, return a store where the latest note in all the histories contains the given tag.

	tanote.hoon: ++  filter-store-tag

Accept a store, and the tag to filter it.

	tanote.hoon:   |=  [unfiltered=store tag=tape]

Build up a new store.

	tanote.hoon:   =/  filtered=store  ~

Recursion point.

	tanote.hoon:   |-

Return a store.

	tanote.hoon:   ^-  store

Once we're done with the unfiltered store, return the filtered store.

	tanote.hoon:   ?~  unfiltered
	tanote.hoon:     filtered

Check whether this history contains the tag in the latest (first) note.

	tanote.hoon:   ?:  (~(has in (extract-tags-history +2:unfiltered)) tag)

For each history with the tag in the latest (first) note, prepend the history to the filtered store, and recurse with the new filtered and unfiltered stores.

	tanote.hoon:     $(unfiltered +3:unfiltered, filtered [+2:unfiltered filtered])

Otherwise, continue with other histories.

	tanote.hoon:   $(unfiltered +3:unfiltered)

## index subtext

### index backlinks

List indices of backlink starts (`[[`) in text.

	tanote.hoon: ++  index-backlinks

Accept a tape (usually the note text).

	tanote.hoon:   |=  text=tape

Use [fand](https://urbit.org/docs/hoon/reference/stdlib/2b#++fand) to find indices of backlinks.

	tanote.hoon:   (fand "[[" text)

### index tags

List indices of tags in text.

	tanote.hoon: ++  index-tags

Accept a [[string]].

	tanote.hoon:   |=  text=tape

Use [fand](https://urbit.org/docs/hoon/reference/stdlib/2b#++fand) to find indices of tags.

	tanote.hoon:   (weld (fand "#" text) (fand "~" text))

End of core.

	tanote.hoon: --

