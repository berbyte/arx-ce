# ARX

**AI is already writing your code. You just don't see how.**

ARX gives you controlled model execution — it captures the prompts, decisions, tool usage, and workflows behind every AI-assisted session, so you can see what actually happened before it reaches production.

> Git shows the outcome. ARX shows the process.

## Demo

[![ARX Demo](https://i.ytimg.com/vi/-sDccFkLom4/maxresdefault.jpg)](https://www.youtube.com/watch?v=-sDccFkLom4)

## Works with your tools

Claude Code · OpenAI Codex · Cursor · GitHub Copilot

Available on **Linux**, **macOS**, and **Windows**.

## Install

<pre><code>curl -fsSL https://get-arx.ber.run/install | bash</code></pre>

Installs the `arx` binary to `~/.local/bin` (or the first writable directory on your `PATH`).

## Quickstart

After installing, run `arx session` before you start your AI tool:

```sh
arx session
# then open Claude Code, Cursor, Codex, etc. as usual
```

When your session ends, ARX generates a report — what you prompted, where you lost time, and what to do differently next time.

## What you get

**For engineers**
- See how you actually operate with AI — prompts, decisions, tool usage
- Understand where you lose time, control, or quality
- Identify where you intervene too early or too late
- Get concrete actions to improve your next session

**For teams**
- Aggregate patterns across engineers
- See what workflows actually work and which setups outperform others
- Identify where teams get stuck

**For leadership**
- Early signals of risk before it hits production
- Real operational insight, not assumptions
- Visibility without friction

## Privacy

Your data stays on your machine. No data is sent to us — ARX uses your own local AI tools (Claude, Codex, etc.) to evaluate your prompts. Any sensitive data ARX captures is stored encrypted locally.

No traffic interception. No IDE proxying. No raw screen or keystroke capture.

## Feedback

Found a bug? [Open an issue](https://github.com/berbyte/arx-community/issues/new/choose)

Have a question or idea? [Start a discussion](https://github.com/berbyte/arx-community/discussions)

Security issue? Email dominis@ber.run — do not open a public issue.
