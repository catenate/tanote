# weldtt

https://urbit.org/docs/hoon/hoon-school/lists#weldt

## user

Rename this program.

	Edit ,s,weldt,weldtt,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=weldt.md' 'file=weldt.hoon'
cp weldt.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept two lists of atoms.

	weldt.hoon: |=  [a=(list @t) b=(list @t)]

Recurse to here.

	weldt.hoon: |-

The `^-` rune ([[kethep]]) constrains output to a certain type.  It takes two children.  In this case, the rune specifies that our gate's output must be `(list @)`—that is, a list of atoms.

	weldt.hoon: ^-  (list @t)

The rune `?~` ([[wutsig]]) tests for null.  If `a` is null, since we have reduced and worked through it, return `b`.

	weldt.hoon: ?~  a
	weldt.hoon:   b

Otherwise, construct a [[list]] from the head of `a`, and the output of this function on the tail of `a`.  This effectively builds a new list from each head of `a`, and then `b` as a [[cell]].

	weldt.hoon: [+2:a $(a +3:a)]
	weldt.hoon:nope: [i.a $(a t.a)]

## test +2 and +3

Run the generator.

```hoon
+tanote!weldt ["urb" "it"]
```

Output of the generator.

```shell-session
<|u r b i t|>
```

## test i. and t.

```hoon
+tanote!weldt ["urb" "it"]
```

Output of the generator.

```shell-session
<|u r b i t|>
```

