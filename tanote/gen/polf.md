# tail-recursive flop

https://urbit.org/docs/hoon/hoon-school/lists#flop

## user

Rename this program.

	Edit ,s,polf,polf,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=polf.md' 'file=polf.hoon'
cp polf.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept a list of atoms.

	polf.hoon: |=  fore=(list @)

Use the rune `=/` ([[tisfas]]) to put a face on a [[hoon/list#list of atoms]] (`(list @)`) and set its initial value to null (`~`, the empty list and last noun). 

	polf.hoon: =/  back=(list @)  ~

The `|-` ([[barhep]]) here is used to create a new gate with one [[hoon/arm]] `$` and immediately call it.  Think of `|-` as the recursion point.

	polf.hoon: |-

The `^-` rune ([[kethep]]) constrains output to a certain type.  It takes two children.  In this case, the rune specifies that our gate's output must be `(list @)`—that is, a list of atoms.

	polf.hoon: ^-  (list @)

The remaining code is the value cast to the [[list of atoms]].

We start with the first two numbers of the series.

	polf.hoon: ?:  =(fore ~)
	polf.hoon:   back

Prepend the head of n (`+2:n`) to c.

	polf.hoon: $(fore +3:fore, back [+2:fore back])

## test

Run the generator.

```hoon
+tanote!polf ~[1 2 3 4]
+tanote!polf ~['the' 'stars' 'my' 'destination']
```

Output of the generator.

```shell-session
~[4 3 2 1]
~[133.507.968.131.440.859.684.234.596 31.085 495.840.228.467 6.645.876]
```

