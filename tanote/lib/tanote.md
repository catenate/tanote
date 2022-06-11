# library functions for %tanote

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

### list default tags

Define the arm.

	tanote.hoon: ++  default-tags

Define the gate with no parameters.

	tanote.hoon:   |=  ~

We return a [[list of strings]].

	tanote.hoon:   ^-  (list @t)

`*` means all notes.  `/` means select notes with backlinks to the selected note.

	tanote.hoon:   ~['*' '/']

### extract tag

Extract a tag from note text.

	tanote.hoon: ++  extract-tag

Accept an octothorpe index, and the text.

	tanote.hoon:   |=  [oi=@ud text=(list @t)]

Figure out when to stop looking for a space.

	tanote.hoon:   =/  max=@  (lent text)
	tanote.hoon:   =/  allowed=(list @t)  "#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

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

### extract tags

Extract tags from note text.

	tanote.hoon: ++  extract-tags

Accept the list of octothorpe indices, and the text [[string]].

	tanote.hoon:   |=  [ois=(list @ud) text=(list @t)]

Build up the list of tags.

	tanote.hoon:   =/  tags=(list)  ~

Recursion point.

	tanote.hoon:   |-

Return a tape.

	tanote.hoon:   ^-  (list)

Once we're done with the list of octothorpe indices, return the list of tags.

	tanote.hoon:   ?:  =(~ ois)
	tanote.hoon:     (flop tags)

For each octothorpe index, extract the tag at that index from the text.

	tanote.hoon:   $(ois +3:ois, tags [(extract-tag +2:ois text) tags])

### octothorpe indices

List indices of octothorpes in text.

	tanote.hoon: ++  octothorpe-indices

Accept a [[string]].

	tanote.hoon:   |=  text=(list @t)

Use [fand](https://urbit.org/docs/hoon/reference/stdlib/2b#++fand) to find indices of octothorpes.

	tanote.hoon:   (fand "#" text)

End of core.

	tanote.hoon: --

