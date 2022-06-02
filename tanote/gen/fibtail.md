# tail-recursive Fibonacci

https://urbit.org/docs/hoon/hoon-school/recursion#exercises

## user

Rename this program.

	Edit ,s,fibtail,fibtail,g

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=fibtail.md' 'file=fibtail.hoon'
cp fibtail.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!fibtail 8
```

Output of the generator.

```shell-session
~[13 8 5 3 2 1 1 0]
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept a parameter of a type which nests inside an [[unsigned integer]] (`@ud` from the [[atom aura list]]).

	fibtail.hoon: |=  n=@ud

Use the rune `=/` ([[tisfas]]) to put a face on a `@ud` and set its initial value to 1. 

	fibtail.hoon: =/  c=(list @ud)  [1 [0 ~]]

The `|-` ([[barhep]]) here is used to create a new gate with one [[hoon/arm]] `$` and immediately call it.  Think of `|-` as the recursion point.

	fibtail.hoon: |-

We start with the first two numbers of the series.

	fibtail.hoon: ?:  =(n 2)
	fibtail.hoon:   c

Prepend to the series the sum of the first two numbers in the series, since these two numbers have the same slots in each iteration.

	fibtail.hoon: $(n (dec n), c [(add +2:c +6:c) c])

## test


```hoon

```

```shell-session

```

