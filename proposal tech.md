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

