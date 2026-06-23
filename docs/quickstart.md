# Quickstart

You just installed ARX. Here's what happened and what to do next.

## What the installer just did

It detected the AI tools you have installed (Claude Code, Cursor, Codex) and wired in hooks for each one it found. That's the entire setup — there's nothing left to configure, and ARX never blocks or modifies the sessions it hooks into.

## How ARX collects data

ARX doesn't watch your network traffic or your IDE. It hooks into your AI tool's session context and reads the structured session files that tool already produces — prompts, tool calls, decisions, token counts. When a session ends, ARX turns that into a report and stores it locally, encrypted at rest.

Nothing about your code, prompts, or tokens leaves your machine. See [Privacy](privacy.md) for exactly what does.

## How this works with git branches

> **Note:** this section describes intended behavior from a docs-writing pass against the public README. If anything here doesn't match what you see running `arx scorecard` on different branches, treat the running binary as correct and tell us — this page will get fixed.

Reports are scoped to the branch you're on. Sessions you run while working on `feature/foo` show up when you run `arx scorecard` or `arx timeline` from that branch; switch to `main` or another feature branch and you get that branch's sessions instead. In practice this means:

- Keep working in branches the way you already do — one branch per feature/fix.
- When a feature is done, run the report from that branch, before you merge or delete it, to review the AI sessions that produced it.
- You don't need to remember to "start" or "stop" tracking anything per branch — just check out the branch and run the command.

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
