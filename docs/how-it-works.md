# How it works

## Hooks, not interception

ARX hooks into your AI tool's session context — not your IDE, not your network traffic. Claude Code, Cursor, Codex, and Copilot all already produce structured session data (prompts, tool calls, decisions, token usage) as part of normal operation. ARX's hooks read that data as the session runs.

This is a deliberate boundary: ARX has no reason to sit on the network path or instrument your editor, so it doesn't. If a hook fails for any reason, it fails silently and logs in the background — it never blocks or modifies the session it's attached to.

## What happens when a session ends

When a session ends, ARX uses your local AI tools to evaluate and summarize what happened — execution quality, prompt clarity, where tokens were spent. That analysis runs entirely on your machine, through the same tool that already has access to your codebase. The resulting report is written to local storage, encrypted at rest ([AES-256-GCM](https://github.com/berbyte/cryptlite)).

## Git branches

Reports are scoped to the branch you're on, so `arx scorecard` and `arx timeline` show you the sessions tied to your current branch rather than your entire history. This lines up with how most people already work: one branch per feature or fix, AI-assisted sessions happening inside it, and a natural point to review those sessions before merging.

## AGENTS.md compliance (`ping`)

The instruction to call `arx ping` is wired into your user-level `CLAUDE.md`/`AGENTS.md` at install time, not your project's own `AGENTS.md`. ARX deliberately doesn't use a `Stop` hook for this — a hook would fire on every turn automatically, giving 100% compliance trivially and no real signal. Instead the agent has to choose to call `arx ping` by following the instruction, which makes the resulting compliance rate meaningful. Missed pings are still caught: ARX tracks turn boundaries and file edits via deterministic hooks, so a turn with file changes and no ping is flagged as a miss regardless of what the agent reports.

## What leaves your machine

Two things, both unrelated to your code or sessions:

| What | When |
|------|------|
| Email + GitHub username | Once, at install time (beta registration) |
| Version check | Hourly (auto-update) |

See [Privacy](privacy.md) for the full breakdown, and [Paranoid setup](paranoid-setup.md) if you want to lock network access down at the OS level.
