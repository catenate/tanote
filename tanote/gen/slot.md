# print noun at a slot

https://urbit.org/docs/hoon/hoon-school/list-of-numbers

## user

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=slot.md' 'file=slot.hoon'
cp slot.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!slot 1
```

Output of the generator.

```shell-session

```

## code

	slot.hoon: |=  n=@
	slot.hoon: =/  noun  [22 [33 44]]
	slot.hoon: +n:noun

