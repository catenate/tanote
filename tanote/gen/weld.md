# my weld

https://urbit.org/docs/hoon/hoon-school/lists#weld

## user

Rename this program.

	Edit ,s,weld,weld,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=weld.md' 'file=weld.hoon'
cp weld.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept two lists of atoms.

	weld.hoon: |=  [a=(list @) b=(list @)]

Recurse to here.

	weld.hoon: |-

The `^-` rune ([[kethep]]) constrains output to a certain type.  It takes two children.  In this case, the rune specifies that our gate's output must be `(list @)`—that is, a list of atoms.

	weld.hoon: ^-  (list @)

The rune `?~` ([[wutsig]]) tests for null.  If `a` is null, since we have reduced and worked through it, return `b`.

	weld.hoon: ?~  a
	weld.hoon:   b

Otherwise, construct a [[list]] from the head of `a`, and the output of this function on the tail of `a`.  This effectively builds a new list from each head of `a`, and then `b` as a [[cell]].

	weld.hoon: [+2:a $(a +3:a)]
	weld.hoon:nope: [i.a $(a t.a)]

## test +2 and +3

Run the generator.

```hoon
+tanote!weld ["urb" "it"]
+tanote!weld [(limo [1 2 ~]) (limo [3 4 ~])]
+tanote!weld [~[1 2] ~[3 4]]
```

Output of the generator.

```shell-session
~[117 114 98 105 116]
~[1 2 3 4]
~[1 2 3 4]
```

## test i. and t.

```hoon
+tanote!weld ["urb" "it"]
+tanote!weld [(limo [1 2 ~]) (limo [3 4 ~])]
+tanote!weld [~[1 2] ~[3 4]]
```

Output of the generator.

```shell-session
~[117 114 98 105 116]
~[1 2 3 4]
~[1 2 3 4]
```

