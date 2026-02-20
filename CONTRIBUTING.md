# Contributing to tailord

Thanks for your interest in improving tailord. This document covers how to contribute vale rules, vocabulary terms, mechanics updates, and editorial workflow changes.

## Adding a new vale rule

Vale rules live in `skills/tailord/vale/styles/AuthenticVoice/`. Each rule is a YAML file.

1. Create a new `.yml` file in the `AuthenticVoice/` directory
2. Follow the [vale style guide](https://vale.sh/docs/keys) for YAML schema
3. Set the appropriate severity level:
   - `error`: Hard violations that must be fixed (banned vocabulary, fabrication patterns)
   - `warning`: Should-fix patterns (filler phrases, hype reinforcement)
   - `suggestion`: Review-and-decide patterns (hedging, contractions)
4. Add per-rule fixing guidance to `skills/tailord/references/vale-rules.md`
5. Test against sample text that contains both true positives and false positives

### Testing a rule

```bash
# Create a test file with examples
echo "This is a test with delve and robust language." > /tmp/test-rule.md

# Run vale with the new rule
skills/tailord/scripts/lint.sh /tmp/test-rule.md
```

## Adding vocabulary terms

### Universal terms (accept.txt)

Add widely-used tech terms, product names, and common jargon to `skills/tailord/vale/styles/config/vocabularies/AuthenticVoice/accept.txt`.

- One term per line
- Alphabetically sorted
- Case-sensitive (add both `GitHub` and `github` if needed)
- Only add terms that any tailord user might encounter

### Personal terms (accept.local.txt)

Terms specific to your writing (people's names, niche company names) go in `accept.local.txt`. This file is gitignored.

## Updating mechanics.md

`skills/tailord/references/mechanics.md` contains universal writing mechanics. Changes here affect all tailord users.

- Keep rules concrete and testable
- Include both good and bad examples
- Explain why the rule exists, not just what it is
- Avoid rules that are purely stylistic preference

## Updating editorial.md

`skills/tailord/references/editorial.md` defines the multi-agent editorial team. Changes here affect how the editorial review works for all users.

- Each agent should have a focused, non-overlapping responsibility
- Agent prompts should be specific enough to produce consistent results
- The synthesis and triage steps should handle any number of findings

## How iterative learning works

The skill learns from editorial feedback through Step 6 (Learning Capture). After each editorial session, the skill:

1. Reviews what was flagged and fixed during the session
2. Presents proposed learnings to the author for approval
3. Writes approved learnings to `references/reference-personal.md` (gitignored, personal)
4. Creates new Vale rules in `vale/styles/AuthenticVoice/` when patterns are regex-matchable
5. Updates `references/vale-rules.md` with per-rule fixing guidance

**Auto-generated Vale rules** follow the same format as manually created rules. They're created in the `AuthenticVoice/` directory and tested against the current draft before being saved. If an auto-generated rule catches a pattern that should be universal (not personal), consider submitting it as a PR to benefit all tailord users.

**reference-personal.md entries** accumulate over time. The learning capture checks for duplicates before appending. If a similar learning already exists, it updates the existing entry with a new example rather than creating a duplicate.

## Pull request checklist

- [ ] New vale rules include examples in `vale-rules.md`
- [ ] Vocabulary additions are alphabetically sorted
- [ ] Changes to mechanics or editorial workflow include rationale
- [ ] No personal content (names, voice patterns, editorial learnings) in public files
- [ ] Scripts work on both macOS and Linux
- [ ] Vale passes on a sample draft with zero errors/warnings after changes

## Code of conduct

Be kind and constructive. Writing is personal, and feedback about writing tools should be respectful of different styles and voices.
