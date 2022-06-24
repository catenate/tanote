# Tanote interfaces

## graph store

### note version structure

An @p called `by`, which is the identity of the author of this version of the note. This field is considered a tag of this version of the note.

A tape called `as`, which is the faction (_confer_ [[Yarvin 2007]]), or the point of view, of this version of the note.  This field is considered a tag of this version of the note.

A cell called `if`, with a @ux and an @p, which store the number and ship of the source of a gora.  If the @ux is not 0, then this gora is checked before a note version is received (naïve approach) or sent (jaded approach).  Both the @ux and @p are considered tags of this version of the note.

A list of @p called `to`, which is the list of recipients of this version of the note.

A tape called `re`, which is the regards, or subject, or title of the note.

A tape called `text`, which is the body of this version of the note.  Tags (`#tag`) in the text are considered tags of this version of the note.  Backlinks ([[back link]]) in the text are references to the `regards` of other histories.

See also the [[tanote/glossary]].

### history structure

A tape called `regards`, which is the `re` field of each note.  All the note versions wich the same `re` are stored together in one history, with a single `regards`.

A list of notes, called `versions`.  The most recent note is first, and the remainder of the notes are in reverse-chronological order, as seen on this ship.

### store structure

A list of histories, each with a different `regards`.

## libraries

### tanote

[[tanote/tanote/lib/tanote]] contains the data structure of a note version, history, and store, and the arms which work with them.

### tanote-ames

Send a note version to another ship.

Receive a note version from another ship.

### tanote-gall

Tanote as an application or agent.

### tanote-gora

Check for the existence of a gora.

### tanote-graphstore

Preserve the contents of a store.

Load a preserved store to a running store.

## generators

### help

[[help]] generates notes which describe usage and internals of the %tanote desk.

### testlib

[[testlib]] generates the results of tests of arms of the [[tanote/tanote/lib/tanote]] library.

## front end

Front end in three parts, split into three horizontal sections, one atop another.

### top section: tags

First, all the tags, listed one after another as a paragraph.

Each tag may separately be selected, which determines which notes are displayed in the second section.  Selected tags are set in bold.

Default tags are `*` (display all notes), `/` (display all notes with backlinks to the selected note), and the @p of our ship.

### middle section: note regards

Second, a paragraph which displays a list of regards, of notes which have the selected tags in the text of the latest version.

One note may be selected, which determines which note or history is displayed in the third section.

Displayed notes which have backlinks to the selected note are set in italics.

### bottom section: note version(s)

Third, a version of the selected note (a paragraph of metadata, and the text as it is formatted by the user), or a list of all the versions of the selected note.

The metadata contains the generated phrase “==no== # ==of== #“.  The first number is the count (the earliest version is 1) of this version in the `versions` list of the note’s history.  The second version is the number of versions in the note’s history.

Some fields in this section are editable, which buffers another version of the note and increments the note version.  The buffered changes are saved as a new version when the button ==no== is clicked.  Clicking on the button-word ==no== adds the buffered version to the beginning of the note’s history, which becomes the most recent version of the note.

Clicking on the button-word ==of== displays the list of versions of this note.  One of these may be selected to display that version of the note.

