# list of numbers

https://urbit.org/docs/hoon/hoon-school/list-of-numbers

## user

Extract hoon files (listr for runes, listw for words) and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=list.md' 'file=list.hoon'
cp list.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!list 5
```

Output of the generator.

```shell-session
~[1 2 3 4]
```

## code

The |- rune functions as a "restart" point for recursion that will be defined later. It takes one child.

Below is a simple Hoon program that takes a single number `n` from the user as input and produces a list of numbers from `1` up to (but not including) `n`.  So, if the user gives the number `5`, the program will produce: `~[1 2 3 4]`.

### create gate (define function)

The [[rune]] `|=` ([[bartis]]) creates a [[hoon/gate]].  Because we're only on the first line, all we're doing with the gate is creating it, and then specifying what kind of input the gate takes with that rune's first child: `end=@`.  The `end` part of our code is simply a name that we give to the user's input so that we can use the number later.  `=@` means that we restrict the kind of input that our gate accepts to the **atom** type, or `@` for short.  An [atom](https://urbit.org/docs/glossary/atom/) is a natural number.

	list.hoon: |=  end=@

Our program is simple, so the _entire program_ is the gate that's being created here. The rest of our lines of code are part of the second child of our gate, and they determine how our gate produces an output.

### name and type a value

This line begins with the `=/` rune ([[tisfas]]) , which stores a value with a name and specifies its type.  It takes three children.

`count=@` (the first child) stores `1` (the second child) as `count` and specifies that it has the `@` type ([[atom]]).

	list.hoon: =/  count=@  1

We're using `count` to keep track of what numbers we're including in the list we're building. We'll use it later in the program.

### mark recursion

The `|-` rune ([[barhep]]) functions as a "restart" point for recursion that will be defined later. It takes one child.

	list.hoon: |-

### typecast output to a list

The `^-` rune ([[kethep]]) constrains output to a certain type.  It takes two children.  In this case, the rune specifies that our gate's output must be `(list @)`—that is, a list of atoms.

	list.hoon: ^-  (list @)

The remaining code is the value cast to the [[list of atoms]].

### check whether we are done

`?:` is a rune ([[wutcol]]) that evaluates whether its first child is `true` or `false`. If that child is `true`, the program branches to the second child. If it's `false`, it branches to the third child. `?:` takes three children.

`=(end count)` checks if the user's input equals to the `count` value that we're incrementing to build the list.  If these values are equal, we want to end the program, because our list has been built out to where it needs to be.  Note that this expression is, in fact, a rune expression, just written a different way than you've seen so far.  `=(end count)` is an _[[irregular form]]_ of `.= end count`, different in looks but identical in operation.  `.=` is a rune ([[dottis]]) that checks for the equality of its two children, and produces a `true` or `false` based on what it finds.

	list.hoon: ?:  .=  end
	list.hoon:     count

### append the list terminator

`~` simply represents the `null` value. The program branches here if it finds that `end` equals `count`.  Lists in Hoon always end with `~`, so we need this to be the last thing we put in our list.

	list.hoon:   ~

### construct list and recurse

`:-` is a rune ([[colhep]]) that creates a **[[cell]]**, an ordered pair of two values, such as `[1 2]`.  It takes two children.  In our case, `:- count` creates a cell out of whatever value is stored in `count`, and then with the product of the next line.

	list.hoon: :-  count

This code is, once again, a compact way of writing a rune expression. All you need to know is that this line of code restarts the program at `|-`, except with the value stored in `count` incremented by `1`. The construction of `(count (add 1 count))` tells the computer, "replace the value of `count` with `count+1`".

	list.hoon: $(count (add 1 count))

[[add]] is a gate that's predefined in the Hoon **[[standard library]]**.  This gate, and other mathematical operators, are defined in [section 1a](https://urbit.org/docs/hoon/reference/stdlib/1a) ([[basic arithmetic]]) of the standard library documentation.

