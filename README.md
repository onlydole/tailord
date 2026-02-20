# tailord

Tailor your drafts to your voice. A Claude Code skill with custom Vale linting rules and a multi-agent editorial team that strips AI writing patterns from prose, so your drafts read like you wrote them on a good day.

## What it does

When you invoke `/tailord` or ask Claude Code to draft a piece, the skill:

1. **Gathers context** via structured questions (format, depth, topic)
2. **Researches** using Exa MCP or WebSearch (for longer pieces)
3. **Loads your voice** from a personal voice profile and universal writing mechanics
4. **Builds a section blueprint** with your approval
5. **Drafts** with two candidate openings for you to choose
6. **Lints** through vale with custom AuthenticVoice rules (hard gate: zero errors/warnings)
7. **Reviews** via a multi-agent editorial team running in parallel
8. **Revises** based on editorial triage with your input

Quick pieces (Short take + Quick hit) skip the editorial team and research steps.

## Requirements

- [Claude Code](https://claude.com/claude-code) CLI
- `vale` CLI (auto-installed on first run)
- Optional: [Exa MCP server](https://docs.exa.ai/) for richer web research

## Installation

Requires Claude Code **1.0.33+**. Check with `claude --version`.

### Option A: Plugin system (recommended)

Inside Claude Code, run two commands. The first registers the catalog, the second installs the skill:

```
/plugin marketplace add onlydole/tailord
/plugin install tailord@onlydole-tailord
```

You can also browse available plugins interactively with `/plugin` and look under the **Discover** tab.

### Option B: Manual clone

```bash
git clone https://github.com/onlydole/tailord.git ~/.claude/plugins/tailord
```

Then register it in your Claude Code settings by adding the plugin path. Open `~/.claude/settings.json` and add:

```json
{
  "plugins": ["~/.claude/plugins/tailord"]
}
```

### Setup

After installation, run the setup script to install prerequisites and create your personal files from templates:

```bash
# From the plugin directory
skills/tailord/scripts/setup.sh
```

This will:
- Install `vale` CLI if missing
- Sync the Google style package
- Create system symlinks for bare `vale` invocations
- Copy `voice.template.md` to `voice.md` for customization
- Copy `reference-personal.template.md` to `reference-personal.md`
- Create `accept.local.txt` for personal vocabulary

## Customization

### Voice profile

The most important customization. Edit `skills/tailord/references/voice.md` to define:

- **Your identity**: who you are, what you write about
- **Your audience**: who reads your work, the relationship
- **Voice characteristics**: the traits that define your style

The template provides good defaults. Adjust them to match your natural writing style.

### Personal reference material

Edit `skills/tailord/references/reference-personal.md` to add:

- Voice patterns with examples from your published work
- Learnings from editorial sessions (mistakes to avoid)
- Narrative flow patterns that work for your content
- Content-type specific editorial learnings

### Vocabulary

Add personal names and niche terms to `skills/tailord/vale/styles/config/vocabularies/AuthenticVoice/accept.local.txt` to suppress false spelling errors. The lint script merges this with the universal `accept.txt` before each run.

### What stays private

These files are gitignored and never leave your machine:

| File | Contains |
|------|----------|
| `references/voice.md` | Your identity, audience, voice characteristics |
| `references/reference-personal.md` | Your editorial learnings and voice examples |
| `accept.local.txt` | Personal names and terms |

## Vale rules

The `vale/` directory contains three style packages:

- **AuthenticVoice** (custom): Rules covering banned vocabulary, filler phrases, AI writing tells, fabricated experience, emotion directives, transition formulas, and more
- **Google**: Standard Google developer documentation style
- **Vale**: Built-in vale rules

See `skills/tailord/references/vale-rules.md` for per-rule fixing guidance.

### Running vale manually

```bash
skills/tailord/scripts/lint.sh your-draft.md
```

The script outputs JSON. Use `--skip-prereqs` for faster repeated runs.

## The editorial team

For substantial pieces, the skill spins up a parallel editorial team:

| Agent | Focus |
|-------|-------|
| Voice Auditor | Sentence-level voice authenticity |
| Fact Checker | Verifiable claims and fabrication detection |
| Anti-Slop Auditor | Contextual quality checklist |
| Structural Editor | Arc, pacing, thesis, transitions |
| Reader Proxy | Developer/leader perspective |
| Manufactured Relatability Detector | Fabricated anecdotes |
| Filler and Hype Stripper | Padding and hype reinforcement |
| Section Value Auditor | Per-section information density |
| Cynical Reader | Maximum suspicion AI detection |
| Copy Editor | Mechanical compliance |
| Narrative Arc Auditor | Cross-sectional coherence |

## License

Apache-2.0. See [LICENSE](LICENSE).
