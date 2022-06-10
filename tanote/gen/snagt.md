# snag text

https://urbit.org/docs/hoon/hoon-school/lists#snag

Take i.c n times.

## user

Rename this program.

	Edit ,s,snagt,snagtt,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=snagt.md' 'file=snagt.hoon'
cp snagt.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## code

Accept a count, and a list of text atoms.

	snagt.hoon: |=  [n=@ c=(list @t)]

If the list is null ([[wutsig]]), we ran out of list, so crash ([[zapzap]]) with type [[%void]], which nests in every other type.

	snagt.hoon: ?~  c
	snagt.hoon:   !!

The first element of the list is at offset 0.

	snagt.hoon:nope: ?:  =(n 0)
	snagt.hoon: ?:  =(0 n)

With `+2:`, the program outputs `i=` before the returned atom.

	snagt.hoon:nope:   +2:c
	snagt.hoon:   i.c

Decrement n, and recurse with the tail.  We should use the same style as the previous line, so prefer `t.` to `+3:`.

	snagt.hoon:nope: $(n (dec n), c +3:c)
	snagt.hoon: $(n (dec n), c t.c)

## test

Run the generator.

```hoon
+tanote!snagt [3 "Hello!"]
+tanote!snagt [1 "Hello!"]
+tanote!snagt [5 "Hello!"]
```

Output of the generator.

```shell-session
`l`
`e`
`!`
```

