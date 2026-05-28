# Chapter 1 — Meet the Terminal

_Last calibrated: 2026-05, against Claude Code v2.x_

A terminal is a window on your Mac where you type commands instead of clicking. That's it. Everything else is just learning what to type. By the end of this chapter you'll know five commands — and those five are enough for the rest of this book.

## Opening Terminal.app

Press `Cmd+Space` to open Spotlight, type **Terminal**, press Enter. A window opens with some text already in it. Something like:

```
yourname@Mac ~ %
```

That last line is called the **prompt**. The blinking square after it is your cursor — that's where what you type will appear. The text before the `%` is your computer telling you who you are (`yourname`) and where you are (`~`, which means "home").

This window will sit on your screen for most of this book. You can resize it; you can change its colours later if you want — but for now, leave it alone and meet it.

> 🛠 Try it
>
> Open Terminal.app via Spotlight.
>
> You should see: a window with a prompt that ends in `%` (or `$` on older configurations), and a cursor.

## 1. `pwd` — where am I?

The terminal always has a notion of "where you are" — a current folder. The command `pwd` (print working directory) tells you which one.

> 🛠 Try it
>
> Type: `pwd` and press Enter.
>
> You should see: a path like `/Users/yourname`. That's your home folder, written from the root of the disk.

`/Users/yourname` and `~` mean the same thing — the second is just a shortcut.

## 2. `ls` — what's here?

`ls` (list) shows you the files and folders inside the current folder.

> 🛠 Try it
>
> Type: `ls` and press Enter.
>
> You should see: a list of folders — Desktop, Documents, Downloads, and probably a few more. These are the same folders you see in Finder when you click your house icon in the sidebar.

If `ls` prints nothing, you're in an empty folder. That's also a valid answer.

## 3. `cd` — go somewhere else

`cd` (change directory) moves you to a different folder. You give it a folder name, and you end up inside it.

> 🛠 Try it
>
> Type: `cd Desktop` and press Enter.
>
> Then type `pwd`.
>
> You should see: `/Users/yourname/Desktop`. You are now "in" Desktop.

To go back up one level — out of Desktop, back to home — use two dots:

> 🛠 Try it
>
> Type: `cd ..` and press Enter.
>
> Then `pwd`.
>
> You should see: `/Users/yourname` again. Two dots mean "the folder containing this one."

If you ever get lost, `cd` with no argument takes you straight home. `cd ~` does the same thing.

## 4. `mkdir` — make a folder

`mkdir` (make directory) creates a new empty folder, named whatever you tell it.

> 🛠 Try it
>
> Type: `mkdir my-first-folder` and press Enter.
>
> Then `ls`.
>
> You should see: your existing folders plus a new one called `my-first-folder`. It's empty for now.

Folder names without spaces are easier to type. The rest of this book uses dashes between words for that reason.

## 5. `open` — bridge back to Finder

`open` takes a file or folder and opens it the same way double-clicking in Finder would.

> 🛠 Try it
>
> Type: `open .` and press Enter.
>
> You should see: a Finder window pops up showing the current folder. The dot (`.`) means "the folder I'm in right now."

This is your safety net. Any time the terminal feels intimidating, `open .` brings you back to a Finder window you already know how to use.

## Recap

| Command | What it does |
|---|---|
| `pwd` | Print the folder you're in |
| `ls` | List what's inside this folder |
| `cd <name>` | Go into a folder |
| `mkdir <name>` | Create a new folder |
| `open <name>` | Open a file or folder in Finder |

These five are everything you need from the terminal for the rest of this book. If you're feeling shaky, redo each 🛠 box until the verification lines feel familiar.

## Next

[Chapter 2 — *Set Up Your Toolbox*](./02-toolbox.md). You'll install Homebrew, Node.js, and Claude Code itself. The five commands above are how you'll navigate to the right place to do it.
