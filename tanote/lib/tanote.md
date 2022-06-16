[~ponhec-picwen]]~sarlur-pilled# library functions for %tanote

https://urbit.org/docs/hoon/hoon-school/libraries

## user

Rename this program.

	Edit ,s,tanote,tanote,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=tanote.md' 'file=tanote.hoon'
cp tanote.hoon /n/local/home/jdc/urbit/zod/tanote/lib/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## code

Define a core.

	tanote.hoon: |%

### note structure

The rune `+$` ([[lusbuc]]) defines a structure arm (type definition).

	tanote.hoon: +$  note  [by=@p as=tape to=(list @p) re=tape text=tape]

### note history structure

	tanote.hoon: +$  history  [regards=tape versions=(list note)]

### default tags

Define the arm.

	tanote.hoon: ++  default-tags

Define the gate with no parameters.

	tanote.hoon:   |=  ~

We return a [[set of tapes]].

	tanote.hoon:   ^-  (set (list @t))

`*` means all notes.  `/` means select notes with backlinks to the selected note.

	tanote.hoon:   (sy ~["*" "/"])

### extract backlink

Extract a [[tanote/glossary#backlink]] from a [[tanote/glossary#text]].

	tanote.hoon: ++  extract-backlink

Accept the index of opening brackets, and the text.

	tanote.hoon:   |=  [start=@ud text=(list @t)]

Start looking for the backlink text after the opening brackets (`[[`).

	tanote.hoon:   =/  cursor=@ud  (add 2 start)

Figure out when to stop looking for a space.

	tanote.hoon:   =/  max=@ud  (lent text)

Build up the substring.

	tanote.hoon:   =/  backlink=(list @t)  ~

Recursion point.

	tanote.hoon:   |-

Return a tape.

	tanote.hoon:   ^-  (list @t)

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
	tanote.hoon:   (extract-backlinks-tape (index-backlinks text.n) text.n)

### extract backlinks from a tape

Extract [[tanote/glossary#backlink]]s from note [[tanote/glossary#text]].

	tanote.hoon: ++  extract-backlinks-tape

Accept the list of backlink starts, and the text of the note.

	tanote.hoon:   |=  [starts=(list @ud) text=(list @t)]

Build up the set of backlinks.

	tanote.hoon:   =/  backlinks=(set (list @t))  ~

Recursion point.

	tanote.hoon:   |-

Return a set of tapes.

	tanote.hoon:   ^-  (set (list @t))

Once we're done with the list of starting indices, return the set of backlinks.

	tanote.hoon:   ?:  =(~ starts)
	tanote.hoon:     backlinks

For each starting index, extract the backlink at that index from the text, and add it to the set of backlinks.

	tanote.hoon:   $(starts +3:starts, backlinks (~(put in backlinks) (extract-backlink +2:starts text)))

### extract tag

Extract a [[tanote/glossary#tag]] from a [[tanote/glossary#text]].

	tanote.hoon: ++  extract-tag

Accept a tag index, and the text.

	tanote.hoon:   |=  [oi=@ud text=(list @t)]

Figure out when to stop looking for a space.

	tanote.hoon:   =/  max=@  (lent text)

For [[tanote/glossary#tag]]s, we want to accept alphanumeric strings following an octothorpe (_eg_ `#test`) as well as the `@p`s (_eg_ `~ponhec-picwen`) of authors ([[tanote/glossary#by]]) and recipients ([[tanote/glossary#to]]).

	tanote.hoon:   =/  allowed=(list @t)  "#-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~"

Build up the substring.

	tanote.hoon:   =/  tag=(list @t)  ~

Recursion point.

	tanote.hoon:   |-

Return a tape.

	tanote.hoon:   ^-  (list @t)

If we are at the string length, stop, and return the tag.

	tanote.hoon:   ?:  =(oi max)
	tanote.hoon:     (flop tag)

Grab the current character.

	tanote.hoon:   =/  t=@t  (snag oi text)

If we are at a character that is not part of a hash, stop, and return the tag.

	tanote.hoon:   ?:  =(~ (find ~[t] allowed))
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
	tanote.hoon:   (extract-tags-tape (index-tags text.n) text.n)

### extract tags from a tape

Extract [[tanote/glossary#tag]]s from note [[tanote/glossary#text]].

	tanote.hoon: ++  extract-tags-tape

Accept the list of tag indices, and the text of the note.

	tanote.hoon:   |=  [starts=(list @ud) text=(list @t)]

Build up the set of tags.

	tanote.hoon:   =/  tags=(set (list @t))  ~

Recursion point.

	tanote.hoon:   |-

Return a set of tapes.

	tanote.hoon:   ^-  (set (list @t))

Once we're done with the list of tag indices, return the set of tags.

	tanote.hoon:   ?:  =(~ starts)
	tanote.hoon:     tags

For each tag index, extract the tag at that index from the text, and add it to the set of tags.

	tanote.hoon:   $(starts +3:starts, tags (~(put in tags) (extract-tag +2:starts text)))

### index backlinks

List indices of backlink starts (`[[`) in text.

	tanote.hoon: ++  index-backlinks

Accept a tape (usually the note text).

	tanote.hoon:   |=  text=(list @t)

Use [fand](https://urbit.org/docs/hoon/reference/stdlib/2b#++fand) to find indices of backlinks.

	tanote.hoon:   (fand "[[" text)

### index tags

List indices of tags in text.

	tanote.hoon: ++  index-tags

Accept a [[string]].

	tanote.hoon:   |=  text=(list @t)

Use [fand](https://urbit.org/docs/hoon/reference/stdlib/2b#++fand) to find indices of tags.

	tanote.hoon:   (weld (fand "#" text) (fand "~" text))

End of core.

	tanote.hoon: --

