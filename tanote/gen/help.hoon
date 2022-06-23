/+  tanote
:-  %say
|=  *
:-  %noun
=/  note0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "note" "A note is composed of several #field: by, as, if, to, re, and text."]
=/  note-history=history:tanote  ["note" ~[note0]]
=/  history0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "history" "A history is a list of notes, with the latest note first; and a regards, which is the same as the re #field of each note."]
=/  history-history=history:tanote  ["history" ~[history0]]
=/  store0=note:tanote  [~ponhec-picwen "reviewer" [0x0 ~ponhec-picwen] ~ "store" "A store is a list of histories."]
=/  store-history=history:tanote  ["store" ~[store0]]
=/  store-help=store:tanote  ~[note-history history-history store-history]
:-  store-help
:-  .=  (extract-tags-store:tanote store-help)
    (sy ~["#field"])
:-  .=  (extract-backlinks-store:tanote store-help)
    ~
:-  (filter-store-tag:tanote store-help "#field")
:-  .=  (filter-store-tag:tanote store-help "#field")
    ~[history-history note-history]
:-  (find-store-regards:tanote store-help "store")
:-  .=  (find-store-regards:tanote store-help "store")
    store-history
~
:: DO NOT EDIT THIS FILE.  Auto-generated from verbose help.md by lit.
