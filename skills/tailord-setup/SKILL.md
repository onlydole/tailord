---
name: tailord-setup
description: |
  Interactive voice profile setup for the tailord writing skill. Guides users
  through creating their voice.md, reference-personal.md, and personal vocabulary
  via a conversational interview instead of manual template editing. Run this
  once after installing the tailord plugin.
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - WebSearch
  - WebFetch
  - AskUserQuestion
  - "Bash(*/tailord/scripts/*)"
  - "Bash(vale *)"
  - "mcp__exa__web_search_exa"
license: Apache-2.0
compatibility: |
  Requires Claude Code with the tailord plugin installed.
  Uses AskUserQuestion for structured interview steps.
  Uses Exa MCP or WebFetch to analyze existing published writing.
metadata:
  version: 1.0.0
---

# Tailord Setup

Interactive onboarding for the tailord writing skill. Creates a personalized voice profile through conversation instead of manual template editing.

## When this skill activates

Use this skill when the user:
- Invokes `/tailord-setup` explicitly
- Asks to set up tailord, configure their voice, or create a writing profile
- Is redirected here from `/tailord` because voice.md is missing or unconfigured

## Workflow

**Working files rule.** All generated files go into the tailord skill directory under `references/` and `vale/styles/config/vocabularies/AuthenticVoice/`. These are configuration files, not working drafts.

### Step 1: Check current state

1. Read the templates to understand the structure:
   - `skills/tailord/references/voice.template.md`
   - `skills/tailord/references/reference-personal.template.md`

2. Check if personal files already exist:
   - `skills/tailord/references/voice.md`
   - `skills/tailord/references/reference-personal.md`
   - `skills/tailord/vale/styles/config/vocabularies/AuthenticVoice/accept.local.txt`

3. If `voice.md` exists and does NOT contain `[PLACEHOLDER]`, `[YOUR NAME]`, or `[YOUR ` markers, inform the user that a voice profile already exists. Use AskUserQuestion:
   - "You already have a voice profile. What would you like to do?" (single-select)
     - Start fresh — replace the existing profile
     - Update — keep the current profile and refine specific sections
     - Cancel — exit setup

   If they choose Cancel, stop. If Update, skip to the relevant section they want to change. If Start fresh, proceed from Step 2.

### Step 2: Identity interview

Use AskUserQuestion to gather the author's core identity in two rounds.

**Round 1 — The basics:**

Ask these two questions together:

1. "What's your name (as it appears in your writing)?" — This is a free-text question, so present it as a single option with "Other" as the escape. Options:
   - Use my git config name (show the name if detectable)
   - Use a different name

2. "What platform do you primarily write for?" (single-select)
   - Substack newsletter
   - Personal blog
   - Company blog / engineering blog
   - Medium or similar platform

**Round 2 — Audience and relationship:**

Ask these two questions together:

1. "Who is your primary audience?" (single-select)
   - Developers and engineers
   - Engineering leaders and managers
   - Tech-adjacent professionals
   - General tech audience

2. "What's the reader relationship?" (single-select)
   - Intimate — subscribers who chose to follow your work
   - Professional — colleagues and industry peers
   - Public — general readership, no prior relationship
   - Mixed — some subscribers, some discovery traffic

### Step 3: Style exploration

Use AskUserQuestion with markdown previews to help the author discover their style preferences.

**Decision 1 — Opening style preference.** Present two example openings for a hypothetical post about "adopting a new technology" and ask which feels more natural:

Option A — Specific-detail cold open:
```markdown
Last Tuesday I mass-migrated 340 Kubernetes manifests to
a tool I'd mass-ignored for two years. The migration took
forty minutes. The existential regret took longer.
```

Option B — Reader solidarity through shared observation:
```markdown
There's a moment in every migration where you realize the
old way wasn't actually that bad — it was just familiar.
That moment hit me somewhere around manifest 200.
```

1. "Which opening style feels more like your natural voice?" (single-select with markdown previews)
   - Direct and specific (Option A)
   - Observational and reflective (Option B)
   - I use both depending on the piece

**Decision 2 — Tone placement.**

2. "Where do you sit on the tone spectrum?" (single-select)
   - Analytical with dry humor — you lead with data and observations, humor sneaks in
   - Warm and curious — you lead with exploration, bring readers along for the ride
   - Playfully skeptical — you question everything but with a grin
   - Earnest and direct — you say what you mean without much irony

**Decision 3 — Sentence style.**

3. "How do your sentences tend to flow?" (single-select)
   - Long and meandering — thoughts develop with tangents and asides
   - Mixed — varies by context, some long, some short
   - Concise but connected — shorter sentences but they flow into each other

**Decision 4 — Anti-patterns.**

4. "Which writing habits do you want to avoid?" (multi-select)
   - Lecturing the reader (telling them what to think)
   - Manufactured relatability ("If you're like me...")
   - Burying the point under too much context
   - Being too cautious or hedge-heavy

### Step 4: Analyze existing writing (optional)

Use AskUserQuestion:

1. "Do you have published writing we can analyze to extract your voice patterns?" (single-select)
   - Yes — I'll share URLs
   - Skip — I'd rather define my voice from scratch

If the author chooses Yes:
- Ask them to paste 1-3 URLs of their best published writing
- Use Exa (`mcp__exa__web_search_exa`) or WebFetch to retrieve the content
- Analyze the writing for:
  - Typical opening patterns (what do they lead with?)
  - Sentence length and rhythm (long/short, varied?)
  - Emotional range (analytical? vulnerable? humorous?)
  - Transition patterns between sections
  - Use of questions (rhetorical vs. genuine inquiry)
  - Specific phrases or constructions they reuse
- Summarize the findings to the author before proceeding

### Step 5: Generate voice.md

Using all interview answers and any writing analysis, generate `skills/tailord/references/voice.md` by filling in the template skeleton:

1. Replace `[YOUR NAME]` with the author's name
2. Replace `[PLATFORM, e.g., ...]` with their platform
3. Replace `[YOUR AUDIENCE, e.g., ...]` with their audience
4. Replace `[RELATIONSHIP STYLE, e.g., ...]` with their reader relationship
5. Fill in the voice characteristics with examples derived from their style choices
6. Fill in example phrases for curiosity, skepticism, and vulnerability based on their tone

Present the generated voice.md to the author using AskUserQuestion with a markdown preview:

- "Here's your voice profile. How does it look?" (single-select)
  - Looks good — save it
  - Needs tweaks — let me suggest changes
  - Start over — let's redo the interview

Allow up to 2 revision rounds. After revisions, write the file to `skills/tailord/references/voice.md`.

### Step 6: Generate reference-personal.md

Generate `skills/tailord/references/reference-personal.md` using the template structure:

- If writing samples were analyzed in Step 4, fill in the voice patterns sections with concrete examples extracted from their published work
- Fill in the opening formula section based on their stated preferences
- Fill in anti-patterns based on their Step 3 selections
- Leave the "Learnings from Editorial Sessions" and "Editorial Learnings (Content-Type Specific)" sections with descriptive prompts like `[Will be filled as you use /tailord and learn from editorial feedback]` — these get populated through use, not setup

Write to `skills/tailord/references/reference-personal.md`.

### Step 7: Personal vocabulary

Use AskUserQuestion:

1. "Are there names, tools, or terms you use frequently that might trip up a spell checker?" (single-select)
   - Yes — let me list some
   - Skip for now — I'll add terms as they come up

If Yes, ask them to provide the terms (free text via "Other" option or conversationally). Write each term on its own line to `skills/tailord/vale/styles/config/vocabularies/AuthenticVoice/accept.local.txt`. If the file already exists, append new terms without duplicating existing ones.

### Step 8: Run Vale setup

Execute the prerequisite checks and setup:

```bash
skills/tailord/scripts/setup.sh
```

This ensures Vale is installed, Google styles are synced, and system symlinks are created. The script is idempotent and safe to re-run.

### Step 9: Confirm and summarize

Present a summary of everything that was created:

```
Setup complete! Here's what was configured:

- voice.md — Your personal voice profile
  [1-sentence summary of their identity/audience/style]

- reference-personal.md — Your writing reference
  [Note about which sections were filled vs. left for future use]

- accept.local.txt — Personal vocabulary
  [Number of terms added, or "empty — add terms as needed"]

- Vale — Style linting ready
  [Vale version and status]

To start writing, use /tailord with your next piece.
```

## Key principles

- Guide, don't prescribe. The interview discovers the author's existing voice — it doesn't impose one.
- Show, don't tell. Use concrete examples in every AskUserQuestion so authors can react to specifics rather than abstractions.
- Respect existing work. If files already exist, always ask before overwriting.
- Leave room for growth. Editorial learnings sections are meant to accumulate over time through actual use of `/tailord`.
