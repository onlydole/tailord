---
name: tailord
description: |
  Co-write blog posts, newsletters, and articles in the author's authentic
  voice. Use when the user asks to write, draft, edit, or review any prose
  content including Substack posts, blog articles, newsletters, outreach emails,
  or long-form writing. Automatically spins up a multi-agent editorial team for
  substantial pieces. Based on a Writing Style Guide with research from
  top dev/AI writers. Do NOT use for code documentation, technical
  docs, README files, git commit messages, or internal comms.
allowed-tools:
  - "Bash(vale *)"
  - "Bash(*/tailord/scripts/*)"
  - Task
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - WebSearch
  - WebFetch
  - AskUserQuestion
  - "mcp__exa__web_search_exa"
  - "mcp__exa__web_search_advanced_exa"
license: Apache-2.0
compatibility: |
  Requires Claude Code with vale CLI (auto-installed on first run via prereqs.sh).
  Uses Task tool for multi-agent editorial workflow.
  Uses AskUserQuestion for structured decision points at piece shape, blueprint
  approval, opening strategy, and editorial triage.
  Not compatible with Claude.ai or API without code execution.
metadata:
  version: 1.1.0
---

# Tailord

Co-write with the author using their authentic voice and a multi-agent editorial workflow.

## Getting started

Prerequisites auto-install on first run. The `lint.sh` and `setup.sh` scripts both source `scripts/prereqs.sh`, which detects and installs the vale CLI, syncs the Google style package, and stamps a version file for future update checks.

To run full setup (including system symlinks for bare `vale` invocations):

```
scripts/setup.sh
```

Then copy `references/voice.template.md` to `references/voice.md` and customize it with your identity, audience, and platform.

## When this skill activates

Use this skill when the user:
- Asks to write, draft, or compose a blog post, newsletter, or article
- Asks to edit or review prose for voice and style
- Mentions Substack, writing, drafting, or publishing
- Wants help with outreach emails or any long-form writing
- Invokes `/tailord` explicitly

## Workflow

**Working files rule.** Never write drafts, intermediate outputs, task files, or any content into the skill directory. That directory is for skill configuration only. All working files go into the user's current working directory.

### Step 1: Understand the piece

Use AskUserQuestion to gather structured input from the author at two decision points:

**Decision 1 — Piece shape.** Present these two questions:

1. "What format is this piece?" (single-select)
   - Newsletter
   - Blog post
   - Short take

2. "How deep does this go?" (single-select)
   - Quick hit (~500 words)
   - Medium (~1,200 words)
   - Deep dive (~2,500+ words)

**Routing:** If the author picks Quick hit + Short take, skip the editorial team (Step 4), research (Step 1.5), and blueprint (Step 2.5). Go straight from voice loading to drafting.

After the format questions, ask any follow-up clarifications conversationally:
- Topic and angle (what's the point of view?)
- Audience (Substack subscribers by default, but could be different)
- Any specific sources, experiences, or examples to include

### Step 1.5: Research (when needed)

If the piece requires looking up tweets, articles, source material, or fact-checking, prefer the Exa MCP tools (`mcp__exa__web_search_exa` and `mcp__exa__web_search_advanced_exa`) over the built-in `WebSearch` tool. Exa returns cleaner, more complete content that's easier to work with for writing. Use `web_search_advanced_exa` with the `category` filter (e.g., `"tweet"` for X/Twitter posts, `"news"` for articles) when you know the content type. Fall back to `WebSearch` or `WebFetch` only if Exa doesn't return results.

### Step 2: Load the voice and mechanics prompts

First, check that the voice profile is ready. Read [references/voice.md](references/voice.md). If the file does not exist, or if it contains `[PLACEHOLDER]`, `[YOUR NAME]`, `[YOUR `, or other unfilled template markers, **stop and tell the user**:

> Your voice profile isn't configured yet. Run `/tailord-setup` to create one through a quick interview, then come back to `/tailord`.

Do not proceed with drafting until voice.md contains a real, filled-in voice profile.

Once confirmed, read [references/voice.md](references/voice.md) for the author's identity, audience, and voice characteristics. Read [references/mechanics.md](references/mechanics.md) for the structural patterns, sentence-level rules, formatting, and anti-AI writing mechanics. Together, these are the rules for every sentence you write.

For deeper context on writer techniques, rhetorical patterns, AI writing tells, and voice examples, read [references/reference.md](references/reference.md). This is optional for quick pieces but recommended for longer essays where you need richer stylistic choices. If the file [references/reference-personal.md](references/reference-personal.md) exists, read it too for the author's personal voice patterns, editorial learnings, and narrative flow examples.

### Step 2.5: Build a section blueprint

Before writing prose, create a blueprint assigning every key fact and concern to exactly one section. For each section, list:
- The single new thing this section teaches
- The altitude (tactical vs. strategic)
- How it advances past the previous section
- The transition connecting its opening to the previous section's closing

Blueprint must pass two tests: (1) no fact appears in more than one section, (2) adjacent sections operate at different altitudes or angles.

**Decision 2 — Blueprint approval.** Present the section blueprint to the author using AskUserQuestion with a markdown preview showing the blueprint. Options:
- Approve — proceed to drafting
- Reorder — author wants sections in a different sequence
- Restructure — author wants to merge, split, or replace sections

Allow a maximum of two revision rounds. After two rounds, proceed with the current blueprint.

### Step 3: Draft

**Decision 3 — Opening strategy.** Before writing the full draft, generate two candidate openings (2-3 paragraphs each) using different voice.md strategies (e.g., reader solidarity vs. specific-detail cold open). Present both via AskUserQuestion with markdown previews. The author picks one. Do not merge elements from the rejected opening.

Write the piece following every instruction in references/voice.md and references/mechanics.md, using the section blueprint from Step 2.5 as your structural guide. Pay special attention to:
- Opening with reader solidarity (vary the approach)
- Grounding in specifics (real names, numbers, time estimates)
- Emotional range (analytical + personal + curious)
- Flowing sentences (not punchy fragments)
- Ending without summarizing

After the draft is complete, do a section-boundary review pass. Read the last two sentences of each section and the first two of the next. Verify that every boundary advances rather than resets, and that no fact or concern appears in more than one section.

### Step 3.5: Vale lint pass

After drafting, run the draft through vale to catch mechanical voice violations before the editorial team reviews. This catches banned vocabulary, filler phrases, throat-clearing, AI writing tells, and other pattern-matchable issues automatically.

1. Write the draft to the user's current working directory (NOT the skill directory) as `YYYY-MM-DD-title-of-the-doc.md` (lowercase, hyphens between words, date from today). For example, a post titled "My post title here" written today becomes `YYYY-MM-DD-my-post-title-here.md` (with today's actual date). Never write drafts, outputs, or any working files into the skill directory. That directory is for skill configuration only.
2. Run the lint script:
   ```
   scripts/lint.sh YYYY-MM-DD-title-of-the-doc.md
   ```
3. Parse the JSON output. Fix all violations by severity:
   - **error**: Fix immediately (banned vocabulary, negative parallelisms, communication artifacts, knowledge cutoff phrases, sycophancy, spelling)
   - **warning**: Fix all (vocabulary swaps, throat-clearing, hype reinforcement, filler phrases, generic conclusions, promotional language, significance inflation, vague attributions, em dash overuse, floater sentences, transition formulas, fabricated experience, emotion directives, quote framing, limitations preamble)
   - **suggestion**: Review and fix where appropriate (catalog tours, excessive hedging, false ranges, superficial analysis, copula avoidance, condescending assumptions like "just"/"simply"/"obviously", topic-staging filler, verdict before evidence, conjunctive overuse, social proof padding, credential listing, use contractions)
4. Re-run `scripts/lint.sh` to confirm zero errors and zero warnings remain. Suggestions are acceptable if intentional.

**Do NOT proceed to Step 4 until vale returns zero errors and zero warnings. This is a hard gate, not a suggestion. If errors or warnings persist after three fix attempts, flag them for the author before continuing.**

**Handling specific rules.** For detailed per-rule guidance on fixing vale findings, see [references/vale-rules.md](references/vale-rules.md).

This automated pass handles the mechanical checks so the editorial team can focus on voice authenticity, structural quality, and subjective judgment calls that pattern matching can't catch.

### Step 4: Editorial review (auto-spin for substantial pieces)

For anything longer than a few paragraphs, read [references/editorial.md](references/editorial.md) and follow its instructions to spin up the multi-agent editorial team in parallel using the Task tool. The four agents run concurrently and report back with findings.

The team includes four consolidated reviewers: a Voice & Authenticity Reviewer (voice scoring, anti-slop checklist, cynical sentence evaluation), a Fact & Fabrication Checker (claim verification, manufactured relatability detection), a Structure & Arc Editor (section structure, value assessment, narrative coherence), and an Engagement & Clarity Reviewer (developer engagement, filler/hype patterns, link/citation checks).

For shorter pieces, do a single self-review pass against the anti-slop checklist in references/editorial.md before delivering.

### Step 5: Revise

**Decision 4 — Editorial triage.** After all editorial agents report, synthesize findings by category with counts and present to the author using AskUserQuestion:

1. "Which area matters most to you?" (single-select, options dynamically built from the categories that actually have findings — e.g., "Fabricated content (3 findings)", "Voice violations (7 findings)")

2. "Any findings to dismiss?" (multi-select, list the top 3 most likely false positives with brief descriptions)

The author's priority selection overrides the default fix ordering below. Dismissed findings are skipped.

Apply fixes from the editorial team in priority order (adjusted by author's triage):
1. Fabricated content (invented anecdotes, unverified claims)
2. Filler and hype (hype reinforcement, catalog tours, atmospheric padding)
3. Voice violations (sentences that sound like AI)
4. Anti-slop failures (checklist items)
5. Structural issues (arc, pacing, balance)
6. Weakest sentences (Cynical Reader's bottom five)
7. Reader engagement (skippability, shareability)

Present the revised draft to the author with a brief note on what the editorial team found and what changed.

### Step 5.5: Post-editorial Vale re-run

After applying editorial revisions, run `scripts/lint.sh` again on the revised draft. Editorial fixes sometimes introduce new vale violations (new colon splices, uncontracted negatives, filler phrases). Fix any new errors and warnings before presenting the final draft to the author.

### Step 6: Learning capture

After the author has reviewed the final draft and provided any last feedback, run the learning capture step. This is how the skill gets better over time. Read [references/editorial.md](references/editorial.md)'s LEARNING CAPTURE section and follow its instructions.

The learning capture does three things:
1. Records editorial learnings into `reference-personal.md` so future sessions watch for the same patterns
2. Creates new Vale rules when a flagged pattern is regex-matchable, so Vale catches it automatically next time
3. Updates `vale-rules.md` with per-rule fixing guidance for any new rules

**When to run this step:**
- Always run it after a substantial piece goes through the full editorial team
- Skip it for quick pieces that didn't use the editorial team
- Skip it if the session produced no new learnings (all findings were already known patterns)

**Important:** Do NOT auto-write learnings without the author confirming them. Use AskUserQuestion to present proposed learnings and let the author approve, edit, or dismiss each one before writing to files.

## Key principles

- Sense-making over tutorials. Help readers orient, not execute.
- Opinionated over balanced. Have a point of view and defend it.
- Specific over abstract. Real names, real numbers, real examples.
- Vulnerable over authoritative. Show the learning, not just the conclusion.
- Human over polished. Messiness, contradiction, and tangents are features.

## Skill contents

| File | Purpose | When to load |
|------|---------|--------------|
| [references/voice.md](references/voice.md) | Author identity, audience, voice characteristics | Always (Step 2) |
| [references/voice.template.md](references/voice.template.md) | Template for new users to create their voice.md | First-time setup |
| [references/mechanics.md](references/mechanics.md) | Structural patterns, sentence rules, formatting, anti-AI mechanics | Always (Step 2) |
| [references/editorial.md](references/editorial.md) | Multi-agent editorial team instructions | Substantial pieces (Step 4) |
| [references/reference.md](references/reference.md) | Writer profiles, techniques, AI tells | Longer essays or when you need richer stylistic choices |
| [references/reference-personal.md](references/reference-personal.md) | Personal voice patterns, editorial learnings, narrative flow examples. Updated automatically by Step 6. | Always (Step 2), written to (Step 6) |
| [references/vale-rules.md](references/vale-rules.md) | Per-rule guidance for fixing vale findings | When fixing specific vale violations (Step 3.5) |
| [scripts/prereqs.sh](scripts/prereqs.sh) | Shared prerequisite detection, installation, and version tracking | Auto-sourced by lint.sh and setup.sh |
| [scripts/lint.sh](scripts/lint.sh) | Vale linting wrapper with `--no-global` isolation | Every draft (Step 3.5) |
| [scripts/setup.sh](scripts/setup.sh) | Full setup (prereqs + system symlinks + template copies) | First-time setup |

## External dependencies

| Tool | Purpose | When used |
|------|---------|-----------|
| `vale` CLI | Automated style linting with custom AuthenticVoice rules covering banned vocabulary, filler phrases, AI writing tells, fabricated experience, emotion directives, transition formulas, restatement signals, section reset openers, and more. Auto-installed by `prereqs.sh` if missing. | Step 3.5 (every draft) |
| Exa MCP (`mcp__exa__web_search_exa`, `mcp__exa__web_search_advanced_exa`) | Web research, tweet lookup, article retrieval. Auto-configured by the plugin via `.mcp.json` — no API key needed. Preferred over built-in `WebSearch` for cleaner content. Use `web_search_advanced_exa` with `category` filter for typed searches. | Step 1.5 (research) |

Vale config: `vale/.vale.ini` (co-located with the skill, used with `--no-global` to prevent config cascade merging)
Vale styles: `Vale`, `Google`, `AuthenticVoice` (custom)
Vale vocab: `vale/styles/config/vocabularies/AuthenticVoice/accept.txt` (add new tech terms here)
