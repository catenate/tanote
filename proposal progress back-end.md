[[unotes/context]]

# Tanote proposal: progress on the back end

# done

## note

My work on it started with notes and a static page in the repo [catena/tanote](https://github.com/catenate/tanote).  The initial code extracts tags (_eg_ `#test` or `~ponhec-picwen`) and backlinks (_eg_ `[[test]]`) from note text.

Define the structure of a note.  Extract all the details from the history of a note, and a particular note.  Extract tags and backlinks from either a note, or a tape.  Extract tags and backlinks from a history, by considering only the latest (first) note.  Extract tags and backlinks from a store, by composing a union of all the sets extracted from its histories.

Add, as `if` to the note structure, the id (unsigned hex) and source (@p) of a gora which must be present for a version of a note to be received (_confer_ [[2022-06-17 07-18]]).

Add metadata backlinks  (_id est_ `as`) to the set extracted from the text of a note version.

## history 

Add arm to add a note to a history, `h=history:tanote  (add-note-history note history)`.  Given a new note and a history, check whether the `re` of the note matches the `regards` of the history.   If so, prepend the note to the `versions` of the history as the first (latest) version of the note.

Rather than defining the internals of a history, add a note to an empty history.

## store

Define a store as `(list history:tanote)`, initially `~`.

Filter a store of histories of notes, by whether the latest (first) note in the history has a given tag, and return the filtered store.

Find in a store the history with the given regards, and return the history; or return a new history with an empty list, and the given regards.

Add arm to add a note to a store, `s=store:tanote  (add-note-store note store)`.  Given a new note and a store, find the history of the note in the store.  If the new note's `re` is not already in the store as a `regards` of any history, then add a new history with the note, and set its `regards` to the new note's `re`.  If the new note's `re` is already a regards in the store, then use `add-note-history` to add the new note as the latest (first) version in the history's `versions`.

Update a note (add a new version) in a store (create a new store with the updated history of the note).

`list-regards-store` constructs a `(list tape)` of regards of all the histories in a store.  Use this list when the default tag `*` is selected, or when no tags are selected.

## front

Create a new `front` structure to store the tag-selected list of `histories`, a set of tapes `tugs` containing user-selected tags, a set of tapes `tags` containing note-version tags (maintained by tanote) selected by parts of the front end (for tab unseen, and tab sent), and a tape `regards` representing a single note selected from the list of `histories`.  Store the short name of the `tags`-derived store in `tab` for use on another tab of the front end.

## glob

Blazon an [[icon]] square in [Drawshield](https://drawshield.net/index.html), and use it as the image for Tanote in the landscape.

# now

I started private study of the Hoon school documents, and then comes Gall school, and then working through the ~pocwet journal example (which should provide a kind of basis for this project’s agent and interface).

I write literate programs in markdown, to define library functions to extract tags from strings ([tanote.md](https://github.com/catenate/tanote/blob/main/tanote/lib/tanote.md)), to test these library functions ([testlib.md](https://github.com/catenate/tanote/blob/main/tanote/gen/testlib.md)), and to document the help generator ([help.md](https://github.com/catenate/tanote/blob/main/tanote/gen/help.md)).  These literate programs describe the hoon cores line-by-line, and their hoon code is actually extracted by [lit](https://github.com/catenate/sharedo/blob/main/lit.md) from them before being copied and committed to the development fake ~zod desk, and before also being committed to the GitHub repo.

Creating a test case (tanote-help) which generates a store of tanote documentation, as a help resource for using and understanding tanote.

# next

`list-regards-front` constructs the `(list tape)` of regards of histories in a front.

`select-histories-front` creates the `histories` for a front, by applying to its store the various tag and regards filters in the front.

... store, which histories have in their latest version (intersection is the same as the given `(set tape)`) all the tags in either (1) the given `(set tape)` (which will be the set of tags selected in the tags section of the front end); or (2) the set of tags in the `tags` of the store, which is the set of tags selected in the store, created by creating a new store with `tags` set from the tags selected in the front end, and a list of histories filtered by those tags.  `regards-selected` is how we get the filtered list of histories, when tags are selected (the `tags` of the store is not `~`) and `*` is not selected.

Filter the default backing store (warehouse) to derived a shallow working store (shopfront) with only the latest versions of each note.  This is just enough to present the current state of all the stored notes, but we don't want to add versions to this (or any) derived store, and we (obviously) can't see a note's history from this derived store.  We might use this to fork or clone a clean copy of a knowledge base (_eg_, for public consumption), without providing insight into alternatives or the deliberative process.

Filter the default store to contain only note versions with the maintained tag #unseen.

Filter the default store to contain only received notes, where `by` is not our ship.

Filter the default store to contain only note versions with the maintained tag #sent.

Add to the note a set of tapes `tags`, which contains tags maintained by tanote for each note version (_eg_, `#unseen` if it hasn't yet been viewed in the front end, `#sent` if it was ordered to be sent).  `#received` is redundant, since we know a note version was received if its `by`line is not our ship.  `#selected` is redundant with being in a derived store.  `#latest` is redundant with being the first note in a history, and changes as soon as a new version is received or added.

Generate display of visible note regards, which is the list of all notes with the selected tags.

# later

## ships in tapes

Cast @p to a tape and vice-versa. @p tags in text start as tapes, but we will want to treat them as @p. We also want to treat the @p in by, if and to as tags. Add metadata tags (eg, @p as text) to the set extracted from the text of a note version. Generate display of tags from a store, including defaults and @p. Store @p as a separate list, to avoid translating to and from text? What about @p mentioned in text?

## tenant

At the ship owner's request, store the text of a note version to a tenant library or generator Hoon file (named (eg, tanote/lib/tenant-this, tanote/gen/tenant-that) by the regards of the note) of the tanote desk.

At the ship owner's request, recommit the tanote desk, to make available this new tenant code to any Hoon file that includes the patched tenant library, or calls the tenant generator, in the patched tanote desk, from the dojo.  This can create and make available new code (eg, for individualized update or repair of a ship), or patch tanote itself.

## graph store

Store (graph-store?) the overall structure containing version histories of notes.

## share

Share a version of a note with another ship, and set its maintained tag `#sent`.

Receive ~~and accept (move from received store to main store)~~ a version of a note from another ship, and set its maintained tag `#unseen`.  A received note version becomes the latest in its note's history.

Remove all `#unseen` maintained tags.

## gora

Share a note with another ship, if a gora has been granted to that ship (jaded approach checks with the gora issuer).  Receive a note from another ship, if a gora is present (naïve approach checks the current ship).

Implement the mechanism to check for the presence of the requested gora on the receiving ship (naïve approach).  Implement the mechanism to check for the presence of the requested gora on the sending ship (jaded approach).

## stores

Having a tag seems better for ephemeral status such as whether or not it's been seen, rather than an entire other structure, and deal with merges of stores, especially while we don't have a version sort.   Store extra system-maintained tags in `tags` of a version.  The principle should be that we may create and maintain temporary derivatives of the main store; but we should not have multiple permanent stores, and have to reconcile them.

New/received store should be the main, default, live store, because this is the store used to communicate between ships, and to avoid having to reconcile divergent stores. Notes may be moved to other, dead stores, if we find a good way to merge them (reverse-order by save date?).

## delete or replace

No deletes, but a note may be nullified by emptying the most recent version, so it shows up with no tag but `*`.

> He had not written it down, for what he once meditated would not be erased.—JL Borges, "Funes, the memorious"

Something really objectionable might arrive, so that we want to send a note's text to the bit bucket.  To accomplish this, a nullify function could set the text of a note version to `~`, and add the #null maintained tag.

## performance

To improve average search and add performance from _O_(_n_) to _O_(log _n_), maintain a store as a [sorted binary tree](https://en.m.wikipedia.org/wiki/Binary_search_tree) (sorte or eorst), rather than an unsorted list.

Stores could hold, instead of the list of histories, the curry of the function to apply to the warehouse to create the store.  The curried function of the main/complete store would just allow everything.

## date

Add to a note version the absolute date (`@da`) of creation of the note version, in the field `at`.  Add a function that creates a note version, and sets `at` and `by`.  If we add and sort the tree by a date, and move the latest version to the end, this would mean more work to access the latest version of every note, which is the most common case.  Reverse-sort by date?

> Each timeless data structure is a brick in the foundation of digital civilization.

## front end

Integrate with the front end (_confer_ [[interfaces#front end]]).

Provide access to multiple visible stores, possibly in a crossbar access the top, like the new terminal's named tabs and `+`.

As soon as a note version is edited in the front end, it becomes the latest new version.

