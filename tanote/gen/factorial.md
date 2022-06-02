# stack factorial

https://urbit.org/docs/hoon/hoon-school/recursion#factorial-in-hoon

## user

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=factorial.md' 'file=factorial.hoon'
cp factorial.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!factorial 5
```

Output of the generator.

```shell-session
120
```

## code

Accept a parameter of a type which nests inside an [[unsigned integer]] (`@ud` from the [[atom aura list]]).

	factorial.hoon: |=  n=@ud

If we are at 1, return 1.  This terminates recursion, since all values higher than 1 will eventually decrement to 1.

	factorial.hoon: ?:  =(n 1)
	factorial.hoon:   1

Otherwise, we are higher than 1, so return the product of the current number, and this gate’s result with a number 1 less.  To pass the number 1 less than the current number, we invoke the single [[arm]] of this [[gate]], but replace the sample.

	factorial.hoon: (mul n $(n (dec n)))

If you have to manipulate the result of a recursion as the last expression of your gate, as we did in our example, the function is not tail-recursive, and therefore not very efficient with memory.

But the Hoon compiler, like most compilers, is smart enough to notice when the last statement of a parent can reuse the same frame instead of needing to add new ones onto the stack. If we write our code properly, we can use a single frame that simply has its values replaced with each recursion.

