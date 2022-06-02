# tail-recursive factorial

https://urbit.org/docs/hoon/hoon-school/recursion#factorial-in-hoon

## user

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=factotail.md' 'file=factotail.hoon'
cp factotail.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!factotail 5
```

Output of the generator.

```shell-session
120
```

## risk

The Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

## code

Accept a parameter of a type which nests inside an [[unsigned integer]] (`@ud` from the [[atom aura list]]).

	factotail.hoon: |=  n=@ud

Use the rune `=/` ([[tisfas]]) to put a face on a `@ud` and set its initial value to 1. 

	factotail.hoon: =/  t=@ud  1

The `|-` ([[barhep]]) here is used to create a new gate with one [[hoon/arm]] `$` and immediately call it.  Think of `|-` as the recursion point.

	factotail.hoon: |-

If we are at 1, return 1.  This terminates recursion, since all values higher than 1 will eventually decrement to 1.

	factotail.hoon: ?:  =(n 1)
	factotail.hoon:   t

All we are doing here is recursing our new gate and modifying the values of `n` and `t`.  `t` is used as an accumulator variable that we use to keep a running total for the factorial computation.

	factotail.hoon: $(n (dec n), t (mul t n))

We simply multiply `t` and `n` to produce the new value of `t`, and then decrement `n` before repeating.  Since this `$` call is the final and solitary thing that is run in the default case and since we are doing all computation before the call, this version is properly tail-recursive.  We don't need to do anything to the result of the recursion except recurse it again.  That means that each iteration can be replaced instead of held in memory.
