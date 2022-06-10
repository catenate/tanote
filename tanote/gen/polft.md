# tail-recursive flop for strings

https://urbit.org/docs/hoon/hoon-school/lists#flop

## user

Rename this program.

	Edit ,s,polft,polftt,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=polft.md' 'file=polft.hoon'
cp polft.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk.

```hoon
|commit %tanote
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept a list of strings.

	polft.hoon: |=  fore=(list @t)

Use the rune `=/` ([[tisfas]]) to put a face on a [[hoon/list#list of atoms]] (`(list @t)`) and set its initial value to null (`~`, the empty list and last noun). 

	polft.hoon: =/  back=(list @t)  ~

The `|-` ([[barhep]]) here is used to create a new gate with one [[hoon/arm]] `$` and immediately call it.  Think of `|-` as the recursion point.

	polft.hoon: |-

The `^-` rune ([[kethep]]) constrains output to a certain type.  It takes two children.  In this case, the rune specifies that our gate's output must be `(list @t)`—that is, a list of atoms.

	polft.hoon: ^-  (list @t)

The remaining code is the value cast to the [[list of atoms]].

We start with the first two numbers of the series.

	polft.hoon: ?:  =(fore ~)
	polft.hoon:   back

Prepend the head of n (`+2:n`) to c.

	polft.hoon: $(fore +3:fore, back [+2:fore back])

### solution

https://urbit.org/docs/hoon/hoon-school/lists#exercise-solutions

```hoon
::  flop.hoon
::
|=  a=(list @)
```

Use `=|` ([[tisbar]]) instead of `=/` ([[tisfas]]), since our default assignment is the [[bunt]] of the type.

```hoon
=|  b=(list @)
|-
^-  (list @)
```

A list evaluates to true if it is empty (`~`).

```hoon
?~  a
  b
```

Apparently `i.a` is the head of a, `+2:a`, and `t.a` is the tail of a, `+3:a`.

```hoon
$(b [i.a b], a t.a)
```

## test

Run the generator.

```hoon
+tanote!polft ~['the' 'stars' 'my' 'destination']
```

Output of the generator.

```shell-session
<|destination my stars the|>
```

