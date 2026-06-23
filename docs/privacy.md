# Privacy

Your work stays on your machine.

ARX **never** transmits your code, diffs, prompts, tokens, secrets, or API keys to us or anyone else. Prompt analysis runs entirely through your local AI tools, which already hold that data. ARX only reads the structured session files those tools produce; it does not proxy, intercept, or mirror any network traffic.

## What ARX sends externally

| What | When | Why |
|------|------|-----|
| Email + GitHub username | Once, at install time | Beta registration |
| Version check request | Hourly (auto-update) | Keeps the binary current |

## Disabling auto-update

Add this to `~/.arx/config.yaml`:

```yaml
auto_update: disable
```

Once disabled, ARX makes no outbound connections of its own.

## Other protections

- No network traffic interception or IDE proxying
- No raw screen or keystroke capture
- Session data is stored encrypted at rest ([AES-256-GCM](https://github.com/berbyte/cryptlite))

## Want zero network access at all?

For a full hardened setup including blocking all network access at the OS level with AppArmor, Windows Firewall, or macOS tools, see [Paranoid setup](paranoid-setup.md).
