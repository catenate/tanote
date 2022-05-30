[[urbit app]] [[tanote]]

https://dev.tlon.io/

## Publish

The final step is publishing our desk with the `%treaty` agent so others can install it.  To do this, there's a simple command in the dojo.

```bash
:treaty|publish %tanote
```

> **Note**: For desks without a docket file (and therefore without a tile and glob), treaty can't be used.  Instead you can make the desk public with `|public %desk-name`.

> **Note**: Desks aren't publicly readable by default, `:treaty|publish` publishes the metadata and also makes the desk publicly readable, like `|public`.

## Remote install

Let's spin up another fake ship so we can try to install our newly published app.

```bash
cd ~/urbit
./urbit bus
```

> **Note**: For desks without a docket file (and therefore without a tile and glob), users cannot install them through the web interface.  Instead remote users can install it from the dojo with `|install ~our-ship %desk-name`.

In the browser, navigate to [http://localhost:8081](http://localhost:8081/) and login with [[fake ~bus]]'s code which can be found by running `+code` in the dojo for `bus`.  In this case, the default is `riddec-bicrym-ridlev-pocsef`.  Next, type `~zod/` in the search bar, and it should pop up a list of `~zod`'s published apps, which in this case is our `Tanote` app.

When we click on the app, it'll show some of the information from the clauses in the docket file.  Click `Get App`.  It'll ask as if we want to install it.  Finally, click `Get "Tanote"`.  It'll be installed as a tile on `~bus` which can then be opened.

