# Tanote proposal progress

## done

### note

My work on it started with notes and a static page in the repo [catena/tanote](https://github.com/catenate/tanote).  The initial code extracts tags (_eg_ `#test` or `~ponhec-picwen`) and backlinks (_eg_ `[[test]]`) from note text.

Define the structure of a note.  Extract all the details from the history of a note, and a particular note.  Extract tags and backlinks from either a note, or a tape.  Extract tags and backlinks from a history, by considering only the latest (first) note.  Extract tags and backlinks from a store, by composing a union of all the sets extracted from its histories.

Add, as `if` to the note structure, the id (unsigned hex) and source (@p) of a gora which must be present for a version of a note to be received (_confer_ [[2022-06-17 07-18]]).

Add metadata backlinks  (_id est_ `as`) to the set extracted from the text of a note version.

### history 

Add arm to add a note to a history, `h=history:tanote  (add-note-history note history)`.  Given a new note and a history, check whether the `re` of the note matches the `regards` of the history.   If so, prepend the note to the `versions` of the history as the first (latest) version of the note.

Rather than defining the internals of a history, add a note to an empty history.

### store

Filter a store of histories of notes, by whether the latest (first) note in the history has a given tag, and return the filtered store.

Find in a store the history with the given regards, and return the history; or return a new history with an empty list, and the given regards.

Add arm to add a note to a store, `s=store:tanote  (add-note-store note store)`.  Given a new note and a store, find the history of the note in the store.  If the new note's `re` is not already in the store as a `regards` of any history, then add a new history with the note, and set its `regards` to the new note's `re`.  If the new note's `re` is already a regards in the store, then use `add-note-history` to add the new note as the latest (first) version in the history's `versions`.

Update a note (add a new version) in a store (create a new store with the updated history of the note).

## now

I just started Hoon school (I'm working on lists), and then comes Gall school and working through the ~pocwet journal example, which should provide a kind of basis for this project’s code.

I am writing literate programs in markdown, to define library functions to extract tags from strings ([tanote.md](https://github.com/catenate/tanote/blob/main/tanote/lib/tanote.md)), and to test these library functions ([testlib.md](https://github.com/catenate/tanote/blob/main/tanote/gen/testlib.md)).  These literate programs describe the hoon cores line-by-line, and the code in the hoon files is actually extracted from the literate programs before it’s copied and committed to the desk, and also committed to the repo.

Create a test case (tanote-help) which generates a store of tanote documentation, as a help resource for using and understanding tanote.

## next

Define a store (list history:tanote), initially ~.

List notes ((list tape) of regards) in a store.  List notes ((list tape) of regards) in a store, which have in their latest version (intersection is the same as the given (set tape)) all the tags in the given (set tape) (which will be the set of tags selected in the tags section of the front end).

Cast @p to a tape and vice-versa.  @p tags in `text` start as tapes, but we will want to treat them as @p.  We also want to treat the @p in `by`, `if` and `to` as tags.  Add metadata tags (_eg_, @p as text) to the set extracted from the text of a note version.  Generate display of tags from a store, including defaults and @p.  Store @p as a separate list, to avoid translating to and from text?  What about @p mentioned in text?

Add to the store a set of tapes `tags` representing the selected tags.  Add to the store a tape `regards` representing the selected note.  Store the current list of histories in `histories`.  Store the short name of the store in `tab` for use on another tab of the front end.

	tanote.hoon: +$  store  [tab=tape tags=(set tape) regards=tape histories=(list note)]

Generate display of visible note regards, which is the list of all notes with the selected tags.

## later

### tenant

At the ship owner's request, store the text of a note version to a tenant library or generator Hoon file (named (eg, tanote/lib/tenant-this, tanote/gen/tenant-that) by the regards of the note) of the tanote desk.

At the ship owner's request, recommit the tanote desk, to make available this new tenant code to any Hoon file that includes the patched tenant library, or calls the tenant generator, in the patched tanote desk, from the dojo.  This can create and make available new code (eg, for individualized update or repair of a ship), or patch tanote itself.

### graph store

Store (graph-store?) the overall structure containing version histories of notes.

### share

Share a version of a note with another ship.  Receive and accept (~~move from received store to main store~~) a version of a note from another ship.

~~Copy received version to a new/received store~~, or with a new/received tag (but where would that tag be stored?)  If we have multiple visible stores (possibly in a crossbar access the top, like the new terminal's named tabs and `+`, we could copy the received note into the `new` store, then delete it from the `new` store after viewing it, or marking all as seen.

### gora

Share a note with another ship, if a gora has been granted to that ship (jaded approach checks with the gora issuer).  Receive a note from another ship, if a gora is present (naïve approach checks the current ship).

Implement the mechanism to check for the presence of the requested gora on the receiving ship (naïve approach).  Implement the mechanism to check for the presence of the requested gora on the sending ship (jaded approach).

### stores

Having a tag seems better for ephemeral status such as whether or not it's been seen, rather than an entire other structure, and deal with merges of stores, especially while we don't have a version sort.   Store extra system-maintained tags in `tags` of a version.  The principle should be that we may create and maintain temporary derivatives of the main store; but we should not have multiple permanent stores, and have to reconcile them.

New/received store should be the main, default, live store, because this is the store used to communicate between ships, and to avoid having to reconcile divergent stores. Notes may be moved to other, dead stores, if we find a good way to merge them (reverse-order by save date?).

### delete or replace

No deletes, but a note may be nullified by emptying the most recent version, so it shows up with no tag but `*`.

> He had not written it down, for what he once meditated would not be erased.—JL Borges, "Funes, the memorious"

### performance

To improve average search and add performance from _O_(_n_) to _O_(log _n_), maintain a store as a [sorted binary tree](https://en.m.wikipedia.org/wiki/Binary_search_tree) (sorte or eorst), rather than an unsorted list.

### date

Add to a note version the absolute date (`@da`) of creation of the note version, in the field `at`.  Add a function that creates a note version, and sets `at` and `by`.  If we add and sort the tree by a date, and move the latest version to the end, this would mean more work to access the latest version of every note, which is the most common case.  Reverse-sort by date?

> Each timeless data structure is a brick in the foundation of digital civilization.

### front end

Front end (_confer_ [[interfaces#front end]]).

