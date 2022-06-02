# cast input to an atom

https://urbit.org/docs/hoon/hoon-school/list-of-numbers

## user

Extract hoon files and copy it to [[fake ~zod]] desk.

```shell
lit 'lit=atomize.md' 'file=atomize.hoon'
cp atomize.hoon /n/local/home/jdc/urbit/zod/tanote/gen/
```

Commit the file in the desk and run it.

```hoon
|commit %tanote
+tanote!atomize 0b1001
```

Output of the generator.

```shell-session
9
```

## code

	atomize.hoon: |=  a=@
	atomize.hoon: ^-  @
	atomize.hoon: a

