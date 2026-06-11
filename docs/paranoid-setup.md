# Paranoid Setup: Running ARX with No Network Access

ARX is distributed as a binary. If you want to verify and control everything it does on the network, this guide walks through locking it down completely — at the config level and at the OS level.

## What ARX actually sends

ARX makes two kinds of outbound connections:

| Connection | When | Destination |
|------------|------|-------------|
| Beta registration | Once, at install time | `ber.run` — submits your email and GitHub username |
| Version check | Hourly | `github.com ` — checks for a newer binary and downloads it if available |

ARX **never** sends:

- Your code, diffs, or file contents
- Your prompts or AI responses
- Token counts, model names, or cost data
- Secrets, API keys, or environment variables
- Anything from your IDE or terminal session

Prompt analysis runs through your local AI agent (Claude Code, Codex, etc.) — the same process that already has access to your codebase. ARX reads the structured session files those tools produce locally; it does not sit on the network path.

## Step 1: Disable auto-update in config

Create or edit `~/.arx/config.yaml`:

```yaml
auto_update: disable
```

With this set, ARX stops the hourly version check entirely. The only remaining outbound event is the one-time install registration, which has already happened by the time you're reading this.

This is the simplest and most portable option. Steps below add OS-level enforcement on top.

## Step 2: Block network access at the OS level

### Linux — AppArmor

AppArmor lets you confine a binary to a profile that denies all network access.

**1. Check that AppArmor is active:**

```bash
sudo aa-status
```

**2. Create a profile for arx:**

```bash
sudo tee /etc/apparmor.d/home.arx << 'EOF'
#include <tunables/global>

# Adjust this path if arx is installed elsewhere
/home/*/.local/bin/arx {
  #include <abstractions/base>

  # Allow reading its own data directory
  owner @{HOME}/.arx/** rw,
  owner @{HOME}/.arx/ rw,

  # Allow reading Claude Code / Codex session files
  owner @{HOME}/.claude/** r,
  owner @{HOME}/.codex/** r,

  # Allow executing local AI tools for analysis
  /usr/bin/* ix,
  /usr/local/bin/* ix,
  owner @{HOME}/.local/bin/* ix,

  # Deny all network access
  deny network,
}
EOF
```

**3. Load and enforce the profile:**

```bash
sudo apparmor_parser -r /etc/apparmor.d/home.arx
sudo aa-enforce /etc/apparmor.d/home.arx
```

**4. Verify:**

```bash
sudo aa-status | grep arx
```

You should see `arx` listed under `processes in enforce mode`.

To test that the block works:

```bash
arx version   # should work
strace -e trace=network arx timeline 2>&1 | grep -v "^---"
```

**Unloading the profile** (if you want to re-enable network access):

```bash
sudo apparmor_parser -R /etc/apparmor.d/home.arx
```

---

### macOS — Application Firewall + third-party tools

macOS's built-in Application Firewall (`System Settings → Network → Firewall`) only controls **incoming** connections. To block **outbound** connections from a specific binary, you need a third-party tool.

**Option A: LuLu (free, open source)**

[LuLu](https://objective-see.org/products/lulu.html) by Objective-See prompts you whenever an application tries to make an outbound connection. When `arx` first runs, LuLu will ask whether to allow or block it — click **Block** and check **Remember this decision**.

**Option B: Little Snitch (paid)**

[Little Snitch](https://www.obdev.at/products/littlesnitch/) provides rule-based outbound firewall control. Create a rule:

1. Open Little Snitch Rules
2. Add rule: `arx` → **Deny** → **Any Connection** → **Forever**

---

### Windows — Windows Defender Firewall

Windows Defender Firewall can block outbound connections per executable.

**Using the GUI:**

1. Open **Windows Defender Firewall with Advanced Security** (search for it in Start)
2. Click **Outbound Rules** → **New Rule**
3. Select **Program** → Next
4. Browse to the `arx.exe` path (typically `%USERPROFILE%\.local\bin\arx.exe`)
5. Select **Block the connection** → Next
6. Apply to all profiles (Domain, Private, Public) → Next
7. Name it `Block arx outbound` → Finish

**Using PowerShell (run as Administrator):**

```powershell
New-NetFirewallRule `
  -DisplayName "Block arx outbound" `
  -Direction Outbound `
  -Program "$env:USERPROFILE\.local\bin\arx.exe" `
  -Action Block
```

---

## Verification

After applying any of the above, confirm arx has no network access by running it and checking for connection errors or using a network monitor:

```bash
# Linux: watch for any outbound connections while arx runs
ss -tnp | grep arx

# macOS
lsof -i -n -P | grep arx

# Windows (PowerShell)
Get-NetTCPConnection | Where-Object { $_.OwningProcess -eq (Get-Process arx).Id }
```

If the firewall rule is working, you'll see no entries — or `arx` will log a connection-refused error internally, which it handles gracefully without affecting local functionality.

## Summary

| Layer | Mechanism | Scope |
|-------|-----------|-------|
| Config | `auto_update: disable` in `~/.arx/config.yaml` | Stops version checks; one-time registration already done |
| Linux | AppArmor enforce profile | Per-binary, no network syscalls allowed |
| macOS | LuLu or Little Snitch | Per-binary outbound block |
| Windows | Windows Defender Firewall outbound rule | Per-executable block |

Any of these in isolation is sufficient. Config + OS enforcement is belt-and-suspenders.
