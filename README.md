# ARX

**AI is already writing your code. You just don't see how.**

ARX gives you controlled model execution — it captures the prompts, decisions, tool usage, and workflows behind every AI-assisted session, so you can see what actually happened before it reaches production.

> Git shows the outcome. ARX shows the process.

## Demo

[![ARX Demo](https://i.ytimg.com/vi/-sDccFkLom4/maxresdefault.jpg)](https://www.youtube.com/watch?v=-sDccFkLom4)

## Install

```bash
curl -fsSL https://get-arx.ber.run/install | bash
```

Installs `arx` and `arx-dashboard` to `~/.local/bin` (or the first writable directory on your `PATH`).

### Options

| Variable | Description |
|---|---|
| `ARX_VERSION` | Pin a release tag, e.g. `v1.2.3` (default: latest) |
| `ARX_BIN_DIR` | Override the install directory |
| `ARX_POST_INSTALL` | Editor to wire up after install, e.g. `cursor` |

**Requires:** `curl`, `tar`, `jq`

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

No traffic interception. No IDE proxying. No raw screen or keystroke capture. Structured signals, not invasive data. Engineers see their own data first.
