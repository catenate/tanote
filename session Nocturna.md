[[tanote/tanote]] [[session init]]

General outline of the format of the screen.

> tags and @ps
> 
> names of notes.  separated by periods.  like sentences.
> 
> headers of the text
> body of the text

The starting screen, before adding any version.  The list of @ps comes from %pals.  `|` represents the cursor at the start of a text entry field.  Struck-out text is changeable.  Highlighted text is clickable.  Your own id is italic because it’s in the text of the note.  The star should be bold, since it is selected by default, and highlighted, since it is clickable.

> ==`*`== ==~hatryx-lastud== ==~paldev== ==_~ponhec-picwen_==
> 
> 
> 
> by ~ponhec-picwen as |
> ==to== |
> re |
> ==no== ~~1~~ of 1
> 
> |

Name the note, add some text, set a recipient.

> ==`*`== ==~hatryx-lastud== ==~paldev== ==_~ponhec-picwen_==
> 
> 
> 
> by ~ponhec-picwen as ~~muse~~
> ==to== ~~`~`petlod-byrons~~
> re ~~Nocturna~~
> ==no== ~~1~~ of 1
> 
> ~~She walks in beauty, like the night…~~

==no== saves the note, adding a version, if the version number is not already stored.

Add tags and @ps automatically when a version is added, if not already known.

Add note regards automatically when a version is added, if not already known.  Bold the name of the current note.

The text of the note is no longer editable.

> ==`*`== ==~hatryx-lastud== ==~paldev== ==~petlod-byrons== ==_~ponhec-picwen_== ==beauty== ==night==
> 
> ==**Nocturna**==.
> 
> by ~ponhec-picwen as muse
> ==to== ~petlod-byrons
> re Nocturna
> ==no== 1 of 1
> 
> She walks in #beauty, like the #night…

Edit and resave to add another version and its tags and @ps.

> ==`*`== ==~hatryx-lastud== ==~paldev== ==_~petlod-byrons_== ==_~ponhec-picwen_== ==_beauty_== ==_bright_== ==_dark_== ==_day_== ==_Heaven_== ==_light_== ==_night_==
> 
> ==**Nocturna**==.
> 
> by ~ponhec-picwen as ~~poet~~
> ==to== ~~`~`petlod-byrons~~
> re ~~Nocturna~~
> ==no== ~~2~~ of 2
> 
> ~~She walks in #beauty, like the #night 
> of cloudless climes and starry skies
> and all that’s best of #dark and #bright
> meet in her aspect and her eyes
> this mellow’d to that tender #light
> which #Heaven to gaudy #day denies.~~

Set the version field and click ==no== to switch back to the previous version.

> ==`*`== ==~hatryx-lastud== ==~paldev== ==_~petlod-byrons_== ==_~ponhec-picwen_== ==_beauty_== ==bright== ==dark== ==day== ==Heaven== ==light== ==_night_==
> 
> ==**Nocturna**==.
> 
> by ~ponhec-picwen as muse 
> ==to== ~petlod-byrons
> re Nocturna
> ==no== 1 ==of== 2
> 
> She walks in #beauty, like the #night…

==To== adds a version (if not already added), and sends the text to any named recipients.  Re-sending an existing version adds a new version for the recipient.

==Of== lists, in the text section, the versions of the node available, each with the first line, or the (beginning of the) diff from the previous version.

> 1 muse: She walks in #beauty, like the #night…
> 2 poet: She walks in #beauty, like the #night~~...~~**of cloudless climes and starry skies**

