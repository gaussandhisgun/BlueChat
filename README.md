# BlueChat
Reverse engineering Samsung's Bluetooth Chat from old dumbphones

# What is it?
Some old Samsung dumbphones have a feature called Bluetooth Chat. Its a small proprietary chat protocol that relies on Bluetooth, allowing users to create small local chats between each other.

# Why now?
According to [yet another BS suggestion by russian government](https://mastodon.ml/@cutiefuchs1997/110898711549119047), using Internet now can lead to *any of your data* being accessed by the feds. If there's one thing I would like to *not* happen to my data, its feds looking at it and misunderstanding my jokes. So, an old decentralized service is *exactly* what we need, eh?

# Format

My Samsung B5722 Duos sends chat messages as `.vnt` notes. Old Samsung phones use `.vnt` as a common format for regular text notes, so if you try to send a Bluetooth Chat message to, say, Star 5230 (that does *not* have bluetooth chat), it goes to Notes.

A sample note looks like this:

```
BEGIN:VNOTE
VERSION:1.1
BODY;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:Sample Text
DCREATED:20220612T221205
X-SAMSUNG-BTM:SUPPORT
END:VNOTE
```

Its a text file. Yeah. The text is put into the end of the third line. Not providing any text can crash some phones.

`DCREATED` is the date, tho it usually does not matter in the Bluetooth Chat context.

`X-SAMSUNG-BTM` seems to be the flag that tells the phone that this Note is not a regular Note, but a Chat message.

A [linux bash script](./btnotify.sh) is provided by me to try and send sample notes to phones.
