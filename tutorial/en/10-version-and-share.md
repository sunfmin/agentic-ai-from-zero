# Chapter 10 — Version-Control and Share Your Skill

_Last calibrated: 2026-05, against Claude Code v2.x_

In chapter 7 you split that review skill into multiple files. Now it's really yours — a genuine thing with a `SKILL.md` and a `principles.md`. This chapter does two things: **checkpoint** it (so you can roll back to an earlier version any time), and **publish** it to share with other people.

You won't learn git commands in this chapter. git is a **version control** tool — it remembers what a folder looked like at every change you made. But you don't type it yourself: you just ask, and Claude Code runs it for you. What you'll learn is three concepts, plus how to ask Claude.

## Checkpoint your skill

Picture a **checkpoint** (git calls it a **commit**): like a save point in a game, it records the entire state of the folder right now. No matter how you change things later, you can return to any checkpoint.

Let's have Claude make the first checkpoint for your skill folder.

> 🛠 Try it
>
> Start a session inside `~/.claude/skills/review-writing/` (`cd ~/.claude/skills/review-writing`, then `claude`), and tell it:
>
> > Put this folder under git and make the first commit.
>
> You should see: Claude run a few git commands (`git init`, `git add`, `git commit`) and tell you the first checkpoint is made.

⚠️ One trap to avoid: **checkpoint this one skill folder only — not all of `~/.claude/skills/`.** That directory holds every skill you have, mixed together, and can't be shared as one. One skill = one independent checkpoint repository (**repo**).

Once it's saved, change something. Have Claude add a principle to `principles.md`, say. Then ask:

> What changed since the last checkpoint?

Claude shows you a **diff** — which lines were added, which removed. That's the everyday use of version control: **seeing exactly what changed**.

If you don't like the change, just say:

> Roll back to the last checkpoint.

and the skill returns to the previous version. That's the safety net — you can change things boldly, because you can always get back.

## Publish to GitHub to share

Checkpoints live on your own computer. To share your skill with someone else, you publish it to **GitHub** — a website for storing and sharing code and files.

This needs two things: a **GitHub account** (free) and a small tool called **gh** (GitHub's official command line).

If you don't have a GitHub account yet, sign up at github.com now — it's free and takes a few minutes.

Then install gh:

> 🛠 Try it
>
> Type: `brew install gh`
>
> You should see: Homebrew download and install gh, with a final line saying it's done. (Remember Homebrew from chapter 2? Same tool.)

Once it's installed, let gh know your GitHub account. This step is **not** a 🛠 box — it opens your browser, and you verify it by "the browser says you're logged in," just like logging into Anthropic in chapter 2.

Type `gh auth login`, follow its prompts (choose GitHub.com, choose browser login), and authorize in the browser page that opens. When it's done, the terminal shows a login confirmation.

Now you're set. Back in your skill folder's session, tell Claude:

> Publish this skill to my GitHub as a public repo.

Claude runs something like `gh repo create` for you, **pushes** (publishes) your skill up, and gives you a URL — that's your skill's home on GitHub.

## How someone else installs your skill

You send the URL to a friend. To use your skill, all they do on their own computer is ask Claude:

> Clone this repo into my `~/.claude/skills/`: <your URL>

**clone** means "copy it down." Once cloned, the skill is installed in their `~/.claude/skills/` and immediately visible to their Claude — it triggers just like the one you hand-wrote in chapter 6.

That closes the sharing loop: you checkpoint and publish; they clone and it's installed. Not one step asked you to memorize a git command — it's all asking Claude to do it.

## Recap

- **commit (checkpoint)**: records the whole folder as it is now; roll back any time.
- **diff**: see exactly what changed between two checkpoints.
- **push / publish**: send the skill to GitHub.
- **clone / copy down**: how someone else installs your skill into their skills directory.
- One skill = one repo. **Don't** checkpoint all of `~/.claude/skills/`.
- You type none of this yourself — you ask Claude to do it.

## Next

[Chapter 11 — *Install the Engineering Skills, Set the Repo's Protocol*](./11-setup-skills.md). By now you can write and share a skill. The "Part 2" chapters that follow change the goal: install a ready-made set of professional skills and use them to turn Claude Code into your project-management partner — from a one-line idea all the way to a pile of issues an agent can build straight away.
