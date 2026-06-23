# Scorecard: Session quality report

<div align="center">
  <img src="assets/scorecard.svg" alt="ARX Scorecard" width="600">
</div>

The Scorecard gives you a high-level view of how a session went at a glance, without reading through logs.

- **Execution** how many tool calls were made, how many failed, and how time split between thinking and doing
- **Prompt quality** scored ratings for clarity, scope drift, requirement changes, and context resets
- **Cost efficiency** where tokens were wasted: duplicate reads, unnecessary calls, bloated context, and how much of the output you actually kept
- **Insights** what you did well and concrete suggestions to get better results next time

Run it on any branch:

```bash
arx scorecard
```

It reports on the sessions tied to your current branch — see [How it works](how-it-works.md#git-branches) for why.

Related: [Timeline](timeline.md) for the full event-by-event sequence behind a Scorecard.
