# Timeline: Full audit log

<div align="center">
  <img src="assets/timeline.svg" alt="ARX Timeline" width="600">
</div>

The Timeline is a full audit log of every action the agent took, in chronological order.

- **Every tool call, permission request, and sub-agent** one meaningful event per line
- **Token spend per prompt block** with USD cost, so you can see exactly where the bill comes from
- **Context window utilization** see how close each prompt came to the limit
- **Session statistics** duration, model used, permission mode, tool call counts by phase

Where the Scorecard tells you *what*, the Timeline tells you *why* and *how*. Use it when something went wrong and you need to understand the sequence of events.

```bash
arx timeline        # default view with scorecard + event log
arx timeline --raw  # compact audit log, one event per line
```

Related: [Scorecard](scorecard.md) for the high-level summary.
