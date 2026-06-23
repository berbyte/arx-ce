# Ping: AGENTS.md compliance check

<div align="center">
  <img src="assets/ping.svg" alt="ARX Ping" width="600">
</div>

Instructions in `AGENTS.md` are not always followed and there's no built-in way to know which sessions or turns skipped them.

ARX tracks this with a lightweight ping mechanism: the agent calls `arx ping` at the end of each turn. ARX produces a per-turn compliance report and, over time, a per-model compliance rate so you can see that a specific model version honors AGENTS.md in 80% of sessions and draw conclusions about how reliably it follows your other instructions.

```bash
arx ping                          # show compliance report for the current branch
arx ping --reason "what I did"    # record a ping (called by the AI at end of turn)
```

The instruction to call `arx ping` is wired in automatically through your user-level `CLAUDE.md`/`AGENTS.md` during install, so there's nothing to add to your project's own `AGENTS.md`.

**Why not a hook?** A `Stop` hook would fire automatically on every turn, giving you 100% compliance trivially and no signal at all. The point is that the agent must choose to call it by following the AGENTS.md instruction. Missed pings are still caught: ARX already tracks turn boundaries and file edits via deterministic hooks. If files changed in a turn window but no ping was recorded, the miss is detected regardless of whether the agent reported it.
