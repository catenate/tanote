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

I recently had a brainstorm that defined this project, and have been inspired to make something that strikes me as Martian.  I'm doing this on my own, but I have a Computer Engineering degree and 40 years experience writing software (taught myself BASIC on a TI-99/4A and Logo on a Commodore 64), so I should be able to figure it out.

### Progress

I just started Hoon school (I'm up to recursion), and then comes Gall school and working through the journal example, which should provide a sort of basis for thes project’s code.  My work on it so far, which is mostly just notes and a static page:  [catena/tanote](https://github.com/catenate/tanote).

I started writing literate programs in markdown, to define library functions to extract tags from strings ([tanote.md](https://github.com/catenate/tanote/blob/main/tanote/lib/tanote.md)), and to test these library functions ([testlib.md](https://github.com/catenate/tanote/blob/main/tanote/gen/testlib.md)).  These literate programs describe the hoon cores line-by-line, and the code in the hoon files is actually extracted from the literate programs before it’s copied and committed to the desk, and also committed to the repo.  The gates currently create lists of tags, so the next step is to create sets instead.

### Funding

I’ll let the Foundation decide how much this project is worth.  I hope at least one star, which I would use to get more people into Urbit.

---

Good proposals all include the following:

-   A **detailed and clear description of the proposal**. If you're proposing something technical, user stories are a good idea.
-   An overview of **why you are the right person for the job**. A description of your background, familiarity with the project, and professional/education experience are all good starts.
-   Your estimate for **date of completion**.
-   The **amount of funding** you'd like for the project, denominated in stars.
-   What **specific deliverables** will look like.

It's recommended to break your project into _milestones_, each of which must have its own completion dates, funding amounts and deliverables. In general, proposals should target a first deliverable within two months of the start of the project. Proposals should have a maximum of five milestones as scoping a project beyond that is impractical, and each milestone should constitute significant enough work to warrant the reward of a full star.