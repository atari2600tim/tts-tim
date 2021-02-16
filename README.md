# tts-tim
This is a LUA script for Mudlet to use built-in Text To Speech functions until it has native support.

## Description
I made a very simple package that has 2 parts. A trigger will speak every incoming line. A "tts" alias will let you type some things to do extra stuff.

It does not do anything more complicated than that such as let you navigate back and that sort of thing that they're planning to build into the regular program.

It does show off the TTS features that are currently available to LUA scripts though. Someone could improve on this by making something that selects something other than just the last 5 lines, maybe using keyboard shortcuts to roll back a page or something. Just using Lua script I assume you can probably do most of the things that are planned down the line. I'll leave that for someone else if you want to try that. Also it does not filter anything out, so you might have it say "underscore" hundreds of times if your game has some text art.

Here are the available commands, just type "tts", a space, and then one of these commands:
- help - list the commands
- stop - stop speaking, empty the speech queue
- repeat - add the last 5 lines from the screen onto the speech queue
- faster or slower - speed can range from 1 to -1, this one just moves 0.1 steps in either direction
- louder or softer - volume can range from 0 to 1, moves by 0.1
- higher or lower - pitch can go from 1 to -1, moves by 0.1
- pause - stops speaking and keeps speech queued up, but if it isn't speaking then pause doesn't do anything
- resume - continues after a pause
- voice - rotates between available voices
- status - tells your current options
- skip - interrupt and continue to next queued line
- dev - lists some things for debugging

## Purpose
Mudlet does not support screen readers yet.  It uses Qt, which supports screen readers.
You currently can navigate all the configuration windows and menus.
I believe that they've arranged all the elements in a nice tab navigation order and all the buttons have text attached and whatnot.
Mudlet's Github has a [category of issues](https://github.com/Mudlet/Mudlet/issues?q=label%3Aa11y) already there regarding accessibility.
Please let them know if menus and such have any problems or anything else new, or chime in on the existing threads.

However, the main game output window does not have whatever functions are needed for screen readers to be able to read from it.

There is [a bounty](https://www.bountysource.com/issues/88866989-make-mudlet-s-text-window-readable-by-screenreaders) to program such functions, currently at $800.  I put $10 toward it.

Mudlet does however have some LUA functions to speak things.
So in the meanwhile, you can have a trigger that takes every incoming message and send it into that speech system.
Sometimes I see people mention this possibility, and I looked and didn't find any existing packages to do that.
So, I wrote this up.  It is not great for playing with and does not try to emulate real software like NVDA.
It is more like a demonstration of the speech functions.

Maybe it might evolve into something more playable, but for now I'd rather just do the real thing and get $800 out of it.
I'm not against making this script usable, with navigation of buffer and whatnot, but I just don't have the experience with the language.

A side benefit of this script is that I've been able to test out the speech functions and report some bugs.
This script has some code to avoid certain unpatched bugs.

I [posted](https://forums.mudlet.org/viewtopic.php?f=6&t=23015) this script on the Mudlet forums, but for my own convenience I'll put this history on Github.
