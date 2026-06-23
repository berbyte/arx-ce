# Quickstart

You just installed ARX. Here's what happened and what to do next.

## What the installer just did

It detected the AI tools you have installed (Claude Code, Cursor, Codex) and wired in hooks for each one it found. That's the entire setup — there's nothing left to configure, and ARX never blocks or modifies the sessions it hooks into.

## How ARX collects data

ARX doesn't watch your network traffic or your IDE. It hooks into your AI tool's session context and reads the structured session files that tool already produces — prompts, tool calls, decisions, token counts. When a session ends, ARX turns that into a report and stores it locally, encrypted at rest.

Nothing about your code, prompts, or tokens leaves your machine. See [Privacy](privacy.md) for exactly what does.

## How this works with git branches

By default, ARX treats the git branch as the unit of work. As it collects events from your AI tool, it attaches them to whatever branch is currently checked out. Later, when you run `arx scorecard`, `arx timeline`, or `arx ping`, they aggregate every session from every tool onto the current branch — so switching branches changes which sessions you see.

> **Known issue:** on the default branch (e.g. `main`) or in a directory with no git repo, ARX still collects everything, but aggregation doesn't happen — `arx scorecard`, `arx timeline`, and `arx ping` only show the last session instead of the full set. We're working on fixing this.

In practice this means:

- Keep working in branches the way you already do — one branch per feature/fix.
- When a feature is done, run the report from that branch, before you merge or delete it, to review the AI sessions that produced it.
- You don't need to remember to "start" or "stop" tracking anything per branch — just check out the branch and run the command.
- If you're on `main` or outside a git repo, expect to see only the latest session rather than an aggregated view, until this is fixed.

## What to run

Use your AI tool as normal. ARX runs in the background and doesn't get in the way. When a session or a feature is done:

```bash
arx scorecard   # quick read: how the session went
arx timeline    # full sequence: every tool call, in order, with cost
```

`arx ping` compliance tracking against your `AGENTS.md` is already wired in automatically — there's nothing to call yourself.

## Next

- [How it works](how-it-works.md) — the mechanics behind data collection
- [Scorecard](scorecard.md) · [Timeline](timeline.md) · [Ping](ping.md) — full command reference
- [Privacy](privacy.md) — what ARX sends externally and what it never touches
