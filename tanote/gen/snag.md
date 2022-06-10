# my snag

https://urbit.org/docs/hoon/hoon-school/lists#snag

Take i.c n times.

## user

Rename this program.

	Edit ,s,snag,snag,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=snag.md' 'file=snag.hoon'
cp snag.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## code

Accept a count, and a list of atoms.

	snag.hoon: |=  [n=@ c=(list @)]

If the list is null ([[wutsig]]), we ran out of list, so crash ([[zapzap]]) with type [[%void]], which nests in every other type.

	snag.hoon: ?~  c
	snag.hoon:   !!

The first element of the list is at offset 0.

	snag.hoon:nope: ?:  =(n 0)
	snag.hoon: ?:  =(0 n)

With `+2:`, the program outputs `i=` before the returned atom.

	snag.hoon:nope:   +2:c
	snag.hoon:   i.c

Decrement n, and recurse with the tail.  We should use the same style as the previous line, so prefer `t.` to `+3:`.

	snag.hoon:nope: $(n (dec n), c +3:c)
	snag.hoon: $(n (dec n), c t.c)

## test

Run the generator.

```hoon
+tanote!snag [0 ~[11 22 33 44]]
+tanote!snag [1 ~[11 22 33 44]]
+tanote!snag [3 ~[11 22 33 44]]

+tanote!snag [5 ~[11 22 33 44]]
+tanote!snag [0 ~]

+tanote!snag [3 "Hello!"]
+tanote!snag [1 "Hello!"]
+tanote!snag [5 "Hello!"]
```

Output of the generator.

```shell-session
11
22
44

dojo: naked generator failure
dojo: naked generator failure

108
101
33
```

