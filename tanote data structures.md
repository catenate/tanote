# alternative arrangements to store notes

## metadata and text

Store each note independently in a larger list.

```hoon
[[by=@p as=@t] to=(list @p) re=@t te=@t]
```

slot | accessor | noun
--- | --- | ---
+1:c | c | `[by=@p to=(list @p) re=@t te=@t]`
+2:c | | `[by=@p as=@t]`
+3:c | | `[to=(list @p) re=@t te=@t]`
+4:c | (by c) | `by=@p`
+5:c | (as c) | `as=@t`
+6:c | (to c) | `to=(list @p)`
+7:c | | `[re=@t te=@t]`
  | | 
+14:c | (re c) | `re=@t`
+15:c | (te c) | `te=@t`

`(ta c)` returns a `(list @t)` of tags (`#[^ ]+`) in `(te c)`.

## grouped by regards

Store all versions by their common regards, within a larger list of all regards.

```hoon
[re [[by as] to te] [[by as] to te]]
```

slot | subexpression | content
--- | --- | ---
+1:c | `[re [[by as] to te] [[by as] to te]]` | list of all notes with the same regards
+2:c | `re` | @t of regards (title) common to all following notes
+3:c | `[[by as] to te] [[by as] to te]` | all the versions of the notes, decreasing to 1
 | | 
+6:c | `[[by as] to te]` | version 2 of the note
+7:c | `[[by as] to te]` | version 1 of the note
 | | 
+12:c | `[by as]` | author and faction of version 2 of the note
+13:c | `[to te]` | recipients and text of version 2 of the note
+14:c | `[by as]` | author and faction of version 1 of the note
+15:c | `[to te]` | recipients and text of version 1 of the note
 | | 
+24:c | `(by +6:c)` (by gets +4) | @p of author of version 2 of the note
+25:c | `(as +6:c)` (as gets +5) | @t of faction of version 2 of the note
+26:c | `(to +6:c)` (to gets +6) | `(list @p)` of recipients of version 2 of the note
+27:c | `(te +6:c)` (te gets +7) | @t of text of version 2 of the note
+28:c | `(by +7:c)` | @p of author of version 1 of the note
+29:c | `(as +7:c)` | @t of faction of version 1 of the note
+30:c | `(to +7:c)` | `(list @p)` of recipients of version 1 of the note
+31:c | `(te +7:c)` | @t of text of version 1 of the note

Construct the list of all regards simply by grabbing +2 from all of the regards in the overall structure.  We don’t have to keep a separate list of regards.  How do we identify backlinks?  We want to know, for the latest version of each note, whether the text of the note contains the regards of the uniquely **selected note** within `[[ ]]`.  If so, present the regards of the _referring note_ in italics, if the note is filtered in by the multiple **selected tags**.

Construct the list of all tags by extracting the list of tags in the text (always `(te +7:c)`) in the latest version (+6) of each regards.  This means that the tags are always up-to-date, but that the history of tags is not presented.  On the plus side, we don’t have to keep a separate list of tags.

Tags include `by` (the `@p` of the author), `as` (the faction of the author with respect to this note), each `to` (`(list @p)` of recipients), and all tags (`#[^ ]+`) in the text.

