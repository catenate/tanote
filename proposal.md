[[~sarlev-sarsen]]: Some reason I can’t join this group, but if you are interested in making this a serious project, submit it at [https://Urbit.org/grants/proposals](https://urbit.org/grants/proposals) and we can see about getting some address space into your hands if you succeed in building something useful.

[[Jason Catena]]
[[~ponhec-picwen]]
[catenaten@gmail.com](mailto:catenaten@gmail.com)

Tanote, a factious note store
web+urbitgraph://group/~ponhec-picwen/tah-noh-tay
just me :)


---

# Tanote proposal

## Technical summary

### Screen layout

In a graphical interface of mostly text (eg, Groups, Escape, Journal), Tanote captures titled, textual notes (a UTF-8 string) with a set of metadata (author, faction, recipients, tags in the text, and backlinks in the text).  It presents three areas of text on the screen: (1) set of all tags in the most recent versions of notes stored locally (authored by the ship owner, or received from others), where each tag is clickable to select it; (2) set of titles of notes, for either all notes, or only notes which contain all the selected tags; one note title may be clicked on at a time, to select it; (3) and the text and metadata of the selected note, or the list of versions of the selected note.

### Additional user interface

Notes which are selected by tags, but which are not the selected note, which contain a backlink to the selected note, are indicated by presenting the note title in italics.  The user can edit the recipients (and text and other metadata; except author, which is set to the ship’s @p) of a note, to send (ie, forward) it to a new set of recipients, which stores it as a new version of the note.

### Storage

All notes with the same title are considered versions of the same note.  A note is stored as a title, and then a list of its versions.  Each note becomes a new immutable version once it has been stored locally (via an add UI element), or once it has been sent to its recipients (which also stores it locally as a new version).  A received note is automatically added to the store, its tags (including metadata), are added to set of tags shown in the tags section (always all known tags in the latest versions of notes), and the title (if new) is added to the set of notes shown in the titles section (if it should be shown by the selected tags).  To make a note disappear again from the index of tags (and also from the set of shown notes, unless we are displaying all notes), the recipient may add a new version with no text.

### Interoperability

I’d like to store these notes in a way that other applications can get to them, which might be %graph-store (I don’t know enough about this yet).  This may mean that the application is architected as a layer that is called by the (minimal) GUI to talk to primitives that actually work with the data, so other programs may use these primitives.  (It’s early days in my understanding of Urbit app architecture.)

### Economy

We could possibly monetize notes, either automatically by gating the sending of the note on a blockchain transaction or the presence of a subscriber gora, or manually by the author not sending the note until the transaction is performed elsewhere.  This was not one of my primary goals in writing this, but it could help people create an economy within Urbit around the text of notes.  (It’s up to the authors to make them worth paying for.;)  There’s a tension between allowing other apps access to notes, and monetizing them, in that the other apps accessing paid notes should not themselves send the note elsewhere, to get around the payment mechanism.

## Project summary

### Qualifications

I recently had a brainstorm that defined this project, and have been inspired to make something that strikes me as Martian.  I'm doing this on my own, but I have a Computer Engineering degree and 40 years experience writing software (taught myself BASIC on a TI-99/4A and Logo on a Commodore 64), so I should be able to figure it out.  Professionally, I’ve been a software build engineer since 1994, in telecoms, build-tool, financial, and electrical-distribution industries, and I use Inferno over top of whichever laptop OS they give me.

### Funding

I’ll let the Foundation decide how much this project is worth.  I hope at least one star, which I would use to get more people into Urbit.

## Progress

### done

My work on it started with notes and a static page in the repo [catena/tanote](https://github.com/catenate/tanote).  The initial code extracts tags (_eg_ `#test` or `~ponhec-picwen`) and backlinks (_eg_ `[[test]]`) from note text.

Define the structure of a note.  Extract all the details from the history of a note, and a particular note.  Extract tags and backlinks from either a note, or a tape.  Extract tags and backlinks from a history, by considering only the latest (first) note.  Extract tags and backlinks from a store, by composing a union of all the sets extracted from its histories.

Filter a store of histories of notes, by whether the latest (first) note in the history has a given tag, and return the filtered store.

Find in a store the history with the given regards, and return the history; or return a new history with an empty list, and the given regards.

### now

I just started Hoon school (I'm working on lists), and then comes Gall school and working through the ~pocwet journal example, which should provide a kind of basis for this project’s code.

I am writing literate programs in markdown, to define library functions to extract tags from strings ([tanote.md](https://github.com/catenate/tanote/blob/main/tanote/lib/tanote.md)), and to test these library functions ([testlib.md](https://github.com/catenate/tanote/blob/main/tanote/gen/testlib.md)).  These literate programs describe the hoon cores line-by-line, and the code in the hoon files is actually extracted from the literate programs before it’s copied and committed to the desk, and also committed to the repo.

Create a test case (tanote-help) which generates a store of tanote documentation, as a help resource for using and understanding tanote.

Add, as `if` to the note structure, the id (unsigned hex, or an id structure from a library?) and source of a gora which must be present for a version of a note to be received (_confer_ [[2022-06-17 07-18]]).

### next

Define a store (list history:tanote), initially ~.

`=store (add-note-to-store note store)`: Given a new note and the store, find the history of the note in the store.  If the new note's re is not already in the store as a regards of any history, then add a new history with the note, and set its regards to the new note's re.  If the new note's re is already a regards in the store, then add the new note as the latest (first) version in the history's versions.  Aka `insert-note-store` as opposed to `insert-note-history`.

List notes ((list tape) of regards) in a store.
List notes ((list tape) of regards) in a store, which have in their latest version (intersection is the same as the given (set tape)) all the tags in the given (set tape) (which will be the set of tags selected in the tags section of the front end).

Cast @p to a tape and vice-versa.  @p tags in `text` start as tapes, but we will want to treat them as @p.  We also want to treat the @p in `by`, `if` and `to` as tags.

### later

Store (graph-store?) the overall structure containing version histories of notes.

Share a version of a note with another ship.  Receive a version of a note from another ship, and add it to the store.

Share a note with another ship, if a gora has been granted to that ship (jaded approach checks with the gora issuer).  Receive a note from another ship, if a gora is present (naïve approach checks the current ship).

Front end (_confer_ [[interfaces#front end]]).

---

Good proposals all include the following:

-   A **detailed and clear description of the proposal**. If you're proposing something technical, user stories are a good idea.
-   An overview of **why you are the right person for the job**. A description of your background, familiarity with the project, and professional/education experience are all good starts.
-   Your estimate for **date of completion**.
-   The **amount of funding** you'd like for the project, denominated in stars.
-   What **specific deliverables** will look like.

It's recommended to break your project into _milestones_, each of which must have its own completion dates, funding amounts and deliverables. In general, proposals should target a first deliverable within two months of the start of the project. Proposals should have a maximum of five milestones as scoping a project beyond that is impractical, and each milestone should constitute significant enough work to warrant the reward of a full star.