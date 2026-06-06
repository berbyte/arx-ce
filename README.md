<a id="readme-top"></a>

<div align="center">
  <img src="https://share.ber.sh/arx-splash.png" alt="ARX: Controlled AI Execution" width="600">
  <h1 align="center">ARX: See what AI actually did to your codebase</h1>
  <p align="center">
    AI is already writing your code. You just don't see how.<br />
    <br />
    ARX captures the prompts, decisions, tool usage, and workflows behind every AI-assisted session —<br />
    so you can see what actually happened before it reaches production.<br /><br />
    <strong>Git shows the outcome. ARX shows the process.</strong>
    <br /><br />
    <a href="#what-is-arx"><strong>Learn More »</strong></a>
    &middot;
    <a href="#install">Install</a>
    &middot;
    <a href="#quickstart">Quickstart</a>
    &middot;
    <a href="https://github.com/berbyte/arx-community/issues/new/choose">Report a Bug</a>
  </p>

  <p align="center">
    <a href="https://github.com/berbyte/arx-community/releases"><img src="https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg" alt="Platform" /></a>
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License" /></a>
  </p>
</div>

---

<details>
<summary><b>Table of Contents</b></summary>

- [What is ARX?](#what-is-arx)
- [Demo](#demo)
- [Install](#install)
- [Quickstart](#quickstart)
- [What you get](#what-you-get)
- [How it works](#how-it-works)
- [Privacy](#privacy)
- [Feedback](#feedback)

</details>

---

## What is ARX?

ARX is a session recorder for AI-assisted development. It sits quietly in the background while you work with Claude Code, Cursor, Codex, or Copilot — capturing the full picture: what you prompted, what the model decided, which tools it called, and where things went sideways.

When the session ends, ARX turns that into a structured report you can act on.

**Works with:** Claude Code · OpenAI Codex · Cursor · GitHub Copilot

---

## Demo

[![ARX Demo](https://i.ytimg.com/vi/-sDccFkLom4/maxresdefault.jpg)](https://www.youtube.com/watch?v=-sDccFkLom4)

---

## Install

```bash
curl -fsSL https://get-arx.ber.run/install | bash
```

Installs the `arx` binary to `~/.local/bin` (or the first writable directory on your `PATH`).

Available on **Linux**, **macOS**, and **Windows**.

---

## Quickstart

Run `arx session` before you start your AI tool:

```bash
arx session
# then open Claude Code, Cursor, Codex, etc. as usual
```

When your session ends, ARX generates a report — what you prompted, where you lost time, and what to do differently next time.

---

## What you get

**For engineers**

| What ARX captures | Why it matters |
|---|---|
| Every prompt and model decision | Understand your actual workflow, not what you think it is |
| Tool calls and file changes | See where the model acted autonomously vs. where you intervened |
| Time and quality loss points | Know exactly where your sessions break down |
| Session-over-session patterns | Get concrete actions to improve your next run |

**For teams**

- Aggregate patterns across engineers
- See what workflows actually work and which setups outperform others
- Identify where teams consistently get stuck or lose quality

**For leadership**

- Early signals of risk before it reaches production
- Real operational insight into AI adoption — not assumptions
- Visibility without adding friction to engineering workflows

---

## How it works

ARX wraps your existing AI tool session. It hooks into the session context — not your IDE, not your network traffic — and records the structured data that your AI tools already produce.

After the session, it uses your local AI tools to evaluate and summarize what happened. Nothing is sent to us.

---

## Privacy

Your data stays on your machine.

- No data sent to ARX servers
- No network traffic interception
- No IDE proxying
- No raw screen or keystroke capture
- Any sensitive data is stored encrypted locally

ARX uses your own local AI tools (Claude, Codex, etc.) to evaluate your sessions.

---

## Feedback

Found a bug? [Open an issue](https://github.com/berbyte/arx-community/issues/new/choose)

Have a question or idea? [Start a discussion](https://github.com/berbyte/arx-community/discussions)

Security issue? Email [dominis@ber.run](mailto:dominis@ber.run) — do not open a public issue.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
