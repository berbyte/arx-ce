<a id="readme-top"></a>
<div align="center">
  <img src="https://share.ber.sh/arx-splash.png" alt="ARX: Controlled AI Execution" width="600">
  <h1 align="center">ARX: See what AI did to your codebase</h1>
  <p align="center">
    AI is already writing your code. You just don't see how.<br />
    <br />
    ARX captures the prompts, decisions, tool usage, and workflows behind every AI-assisted session —<br />
    so you can see what happened before it reaches production.<br /><br />
    <strong>Git shows the outcome. ARX shows the process.</strong>
    <br /><br />
    <a href="#demo"><strong>Learn More »</strong></a>
    &middot;
    <a href="#install">Install</a>
    &middot;
    <a href="#quickstart">Quickstart</a>
    &middot;
    <a href="https://github.com/berbyte/arx-community/issues/new/choose">Report a Bug</a>
  </p>

  <p align="center">
    <a href="https://github.com/berbyte/arx-community/releases"><img src="https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg" alt="Platform" /></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-Elastic%202.0-blue.svg" alt="License" /></a>
    <img src="https://img.shields.io/badge/Works%20with-Claude%20Code%20%7C%20Codex%20%7C%20Cursor%20%7C%20Copilot-blueviolet.svg" alt="Tool Support" />
  </p>
</div>

> [!WARNING]
> **ARX is currently in private beta.** The parser has been tested against 1794 sessions, but your patterns will likely surface edge cases we haven't seen yet. Bugs at this stage are expected and useful — please [report them here](https://github.com/berbyte/arx-community/issues/new/choose).

---

<details>
<summary><b>Table of Contents</b></summary>

- [What is ARX?](#what-is-arx)
- [Demo](#demo)
- [Features](#features)
- [Scorecard](#scorecard)
- [Timeline](#timeline)
- [Ping](#ping)
- [Install](#install)
- [Quickstart](#quickstart)
- [How it works](#how-it-works)
- [Privacy](#privacy)
- [Feedback](#feedback)

</details>

---

## Demo

[![ARX Demo](/docs/assets/demo-splash.png)](https://www.youtube.com/watch?v=-sDccFkLom4)

---

## Features

- **Scorecard** — a session quality report: tool success rate, prompt clarity, token waste, and actionable improvement suggestions
- **Timeline** — a full chronological audit log of every tool call, token cost, and agent decision
- **Instruction compliance** — tracks whether agents follow `CLAUDE.md` instructions turn-by-turn, giving you a measurable signal where you'd otherwise have none

---

## What is ARX?

ARX is a session recorder for AI-assisted development. It sits quietly in the background while you work with Claude Code, Cursor, Codex, or Copilot — capturing the full picture: what you prompted, what the model decided, which tools it called, and where things went sideways.

When the session ends, ARX turns that into structured reports you can act on.

**Works with:** Claude Code · OpenAI Codex · Cursor · GitHub Copilot

---

## Scorecard

<div align="center">
  <img src="docs/assets/scorecard.svg" alt="ARX Scorecard" width="600">
</div>

The Scorecard gives you a high-level view of how a session went — at a glance, without reading through logs.

- **Execution** — how many tool calls were made, how many failed, and how time split between thinking and doing
- **Prompt quality** — scored ratings for clarity, scope drift, requirement changes, and context resets
- **Cost efficiency** — where tokens were wasted: duplicate reads, unnecessary calls, bloated context, and how much of the output you actually kept
- **Insights** — what you did well and concrete suggestions to get better results next time

Run it on any branch:

```bash
arx scorecard
```

---

## Timeline

<div align="center">
  <img src="docs/assets/timeline.svg" alt="ARX Timeline" width="600">
</div>

The Timeline is a full audit log of every action the agent took, in chronological order.

- **Every tool call, permission request, and sub-agent** — one meaningful event per line
- **Token spend per prompt block** — with USD cost, so you can see exactly where the bill comes from
- **Context window utilization** — see how close each prompt came to the limit
- **Session statistics** — duration, model used, permission mode, tool call counts by phase

Where the Scorecard tells you *what*, the Timeline tells you *why* and *how*. Use it when something went wrong and you need to understand the sequence of events.

```bash
arx timeline        # default view with scorecard + event log
arx timeline --raw  # compact audit log, one event per line
```

---

## Ping

Instructions in `CLAUDE.md` are not always followed — and there's no built-in way to know which sessions or turns skipped them.

ARX tracks this with a lightweight ping mechanism. Add a single line to your `CLAUDE.md` telling the agent to call `arx ping` at the end of each turn. ARX then produces a per-turn compliance report showing which turns honored the instruction and which didn't.

It won't catch every violation, and it relies on the agent cooperating to report itself — but it gives you a measurable signal where you'd otherwise have none.

```bash
arx ping                          # show compliance report for the current branch
arx ping --reason "what I did"    # record a ping (called by the AI at end of turn)
```

To enable, add to your project's `CLAUDE.md`:

```markdown
At the end of every turn, run: arx ping --reason "<brief summary of what you did>"
```

---

## Install

```bash
curl -fsSL https://get-arx.ber.run/install | bash
```

Installs the `arx` binary to `~/.local/bin` (or the first writable directory on your `PATH`).

Available on **Linux**, **macOS**, and **Windows**.

**The installer auto-detects your tools.** It checks for Claude Code, Cursor, and Codex, and automatically configures hook integrations for each one it finds. No manual config required — just run the install command and start working.

To remove ARX and all its hooks cleanly:

```bash
arx uninstall
```

---

## Quickstart

1. Run the install command above
2. Use your AI tools as normal — ARX records in the background
3. When you're done, run `arx timeline` to see what happened

```bash
arx timeline
```

That's it. ARX never blocks or modifies your sessions. If a hook fails for any reason, it fails silently and logs in the background.

---

## How it works

ARX hooks into your AI tool's session context — not your IDE, not your network traffic — and records the structured data that your tools already produce.

After the session, it uses your local AI tools to evaluate and summarize what happened. Nothing leaves your machine except your email and GitHub username, which are submitted once at install time so we know who's in the beta.

---

## Privacy

Your work stays on your machine.

ARX **never** transmits your code, diffs, prompts, tokens, secrets, or API keys — to us or anyone else. Prompt analysis runs entirely through your local AI tools, which already hold that data. ARX only reads the structured session files those tools produce; it does not proxy, intercept, or mirror any network traffic.

What ARX does send externally:

| What | When | Why |
|------|------|-----|
| Email + GitHub username | Once, at install time | Beta registration |
| Version check request | Hourly (auto-update) | Keeps the binary current |

**Disabling auto-update**

Add this to `~/.arx/config.yaml`:

```yaml
auto_update: disable
```

Once disabled, ARX makes no outbound connections of its own.

For a full hardened setup — including blocking all network access at the OS level with AppArmor, Windows Firewall, or macOS tools — see [docs/paranoid-setup.md](docs/paranoid-setup.md).

Other protections:

- No network traffic interception or IDE proxying
- No raw screen or keystroke capture
- Session data is stored encrypted at rest ([AES-256-GCM](https://github.com/berbyte/cryptlite))

---

## Feedback

Found a bug? [Open an issue](https://github.com/berbyte/arx-community/issues/new/choose)

Have a question or idea? [Start a discussion](https://github.com/berbyte/arx-community/discussions)

Security issue? Email [dominis@ber.run](mailto:dominis@ber.run) — do not open a public issue.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
