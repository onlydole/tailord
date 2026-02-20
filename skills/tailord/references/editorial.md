# Editorial Workflow
When the author asks you to write or review a substantial piece (anything longer
than a few paragraphs), spin up a multi-agent editorial team after producing
the initial draft. Use Claude Code's Task tool for each agent. Launch all four
agents in parallel in a single message with four Task tool calls. Set the model
parameter on each Task call as noted below (sonnet or haiku).

Pass the full draft text to each agent in its prompt. Also pass the complete
Writing Voice instructions from voice.md so each agent can evaluate against
the actual rules.

AGENT 1 — Voice & Authenticity Reviewer (model: sonnet).
Prompt the agent with the draft and the Writing Voice instructions from voice.md.
This agent combines voice scoring, anti-slop contextual auditing, and cynical
sentence-level evaluation.

Part A — Voice scoring (from Voice Auditor).
Read every sentence and flag any that sound like AI rather than the author. Check
for: reader solidarity in the opening, curiosity framing, flowing sentences,
emotional range, specificity, and contractions. Score each section 1-5 for voice
authenticity and return a list of flagged sentences with suggested rewrites.

Part B — Anti-slop contextual checklist (from Anti-Slop Auditor).
NOTE: The draft has already been run through vale with custom AuthenticVoice rules
that catch banned vocabulary, filler phrases, throat-clearing openers,
negative parallelisms, hype reinforcement, generic conclusions, promotional
language, em dash overuse, and other mechanical patterns. This agent should focus
on the contextual and subjective checklist items below that pattern matching
cannot catch. If the agent spots a mechanical violation that vale should have
caught, flag it as a possible vale gap.

Checklist.
- First sentence states a point (no throat-clearing)
- No "It's not just X, it's Y" structures
- At least one sentence of four words or fewer per section
- Sounds like speech when read aloud (uses contractions throughout)
- Two or fewer em dashes in the whole piece
- No summary conclusion (no "In conclusion," "In summary," "Overall")
- Every claim has a real name, number, or example attached
- Time grounding where relevant (dates, durations, "this week")
- Named patterns where possible ("the scattered leader" not "doing too much")
- Sense-making orientation, not tutorial (helping readers understand, not
  giving them steps to follow)
- Emotional range (not stuck in one analytical or one enthusiastic register)
- Platform-appropriate tone (Substack: intimate letter to someone who chose
  to subscribe, not a broadcast)

Evaluate the draft against every checklist item and report pass/fail with
specific examples.

Part C — Cynical sentence evaluation (from Cynical Reader).
Assume every sentence was written by AI until it proves otherwise. Read with
maximum suspicion and ask of each paragraph: "Would a real person actually write
this, or does it feel assembled from training data?" Return the five weakest
sentences in the entire draft, ranked from worst to least bad, with a one-
sentence explanation for why each one fails. Also identify the three strongest
sentences and explain what makes them work, so the revision can lean into what
is already good.

AGENT 2 — Fact & Fabrication Checker (model: haiku).
Prompt the agent with the draft. This agent combines factual verification and
fabricated relatability detection.

Part A — Factual claim verification (from Fact Checker).
Verify every factual claim. Flag any detail that could be fabricated, including
atmospheric details (times, weather, settings), credentials (who created what),
specific numbers, and technical specifications. For each flagged claim, note
whether the claim is verified, unverified, or fabricated, with a brief
explanation.

Part B — Manufactured relatability detection (from Relatability Detector).
Find sentences where the AI invented a personal anecdote or scene to sound
relatable. The test for every first-person claim: "Did the author provide this
specific experience, or did the AI fabricate it?" Flag sentences like "I opened
the dashboard on Monday and the model I'd been using all week was already the
old one" where the detail (Monday, "all week," the surprise) was not provided
by the author but invented to manufacture a sense of being-there.

For each flagged sentence, suggest a replacement that conveys the same
information without fabricating an experience. Replacements should use verifiable
observations ("The team shipped three updates in two weeks") or direct reader
address ("If you logged in this week, the default model changed") instead.

AGENT 3 — Structure & Arc Editor (model: sonnet).
Prompt the agent with the draft. This agent combines section-level structural
editing, section value assessment, and cross-section narrative arc auditing.

Part A — Section arc and structural checks (from Structural Editor).
Evaluate the arc of the piece. Where does attention drop? Are there callbacks to
earlier concepts? Are sections balanced in length? Does the ending land without
summarizing? Does the opening earn the reader's first three paragraphs? Perform
these explicit checks:
(1) Verify the opening states or strongly implies a thesis — not just an
attention-getter. After reading the opening, a reader must be able to answer
"What is this piece about and what will I gain from reading it?"
(2) Flag ALL vague pronouns (it, that, this, these) at section boundaries
(first and last sentences of every section) and in the closing paragraph.
Every pronoun at these positions must have an unambiguous referent within
the same sentence or the immediately preceding sentence.
(3) Check that the closing paragraph refers to specific things discussed in
the piece by name, not vague references like "all of it," "what's coming,"
or "this moment."
(4) Section-boundary advancement test. Read the last two sentences of every
section and the first two of the next. Flag any boundary where the new section
resets to the same altitude or topic instead of advancing past where the
previous section ended.

Part B — Section value assessment (from Section Value Auditor).
Review each section atomically. For every section, ask: "What specific new
information does the reader gain here?" Perform these checks:
(1) Review the opening sentence of each section in isolation. Does it state
a verifiable fact, or does it assert importance without evidence? Flag any
opening sentence that is a verdict ("This deserves attention") rather than
a fact ("Anthropic released X on Tuesday").
(2) Apply the deletion test to every section: "If I removed this section
entirely, would the reader lose any concrete information they can't get
from the remaining sections?" If not, the section needs substance or should
be merged.
Flag any section where the answer is vague or amounts to "a summary
of what someone said/did." Flag sentences that assert importance without
demonstrating it ("deserves more attention," "the steadiest thing I read").
Flag scenarios presented without a takeaway ("ask X, get Y, watch Z" — so
what?). For each flagged section, state what's missing and suggest what
concrete information would make it earn its space.
(3) Cross-section duplication scan. For every key claim in each section,
search all other sections for the same information expressed in different
words. Flag duplicates and recommend which single section should own each
piece of information.

Part C — Cross-section narrative arc (from Narrative Arc Auditor).
Perform three cross-sectional coherence checks:
(a) Information duplication map. For every key fact, claim, or description,
identify which section owns it. Flag any fact that appears in substantially
similar form in more than one section. For each duplicate, recommend which
section should own it and suggest a one-sentence reference for the other.
(b) Section-to-section advancement. Read the last paragraph of each section
and the first paragraph of the next. Does the second section start at a more
advanced position than where the first ended? Flag any transition where the
reader could swap the two paragraphs without noticing.
(c) Tonal continuity at section boundaries. Check whether the tone shifts
abruptly at section boundaries (e.g., tactical step-by-step into abstract
strategic musing, or vice versa, without a bridge). Flag jarring tonal jumps
and suggest a bridging sentence.

AGENT 4 — Engagement & Clarity Reviewer (model: sonnet).
Prompt the agent with the draft. This agent combines developer reader-proxy
assessment, filler and hype stripping, and the non-redundant mechanical checks
from the original Copy Editor.

Part A — Developer engagement (from Reader Proxy).
Read as a working developer or engineering leader. What hooks them? What would
they skip? What would they share with a colleague? What feels like it was
written for them vs. at them? Return honest reactions paragraph by paragraph.

Part B — Filler and hype patterns (from Filler and Hype Stripper).
Find and flag four specific patterns:
Pattern 1: Hype reinforcement. Clauses that exist only to validate what
was just stated. "And the numbers back that up." "And it shows." "And for
good reason." "Which is no small feat." "Making it a compelling option."
These add no information. For each one, suggest deleting the clause entirely
or ending the sentence before it.
Pattern 2: Catalog tours. Sentences that walk through a comma-separated
list of items as if giving a guided tour of a press release. "A Mac app,
a beefier model, and now something I didn't expect: a brand-new runtime." For each one,
suggest leading with the single most important item and giving others their
own sentences or cutting them.
Pattern 3: Atmospheric padding. Sentences that narrate the experience of
encountering information rather than presenting the information. "Here's a
pattern I keep running into across almost every agentic coding tool I use.
You type a prompt, wait while the agent thinks..." For each one, suggest
starting with the concrete observation or example instead.
Pattern 4: Unsubstantiated assertions. Sentences that claim something is
important, surprising, or shaking without providing evidence for the claim.
"Wrote something that shook me" followed by a description of what he did
(not why it was shaking). "The steadiest thing I read this week" without
saying WHY. For each one, flag the assertion and ask: "Where's the WHY?"

Part C — Link, citation, and emotional claim checks (from Reader Proxy and
Copy Editor).
(1) For every named person, study, project, or tool, verify there is a
markdown link on first mention. Flag every missing citation with the name
and approximate location.
(2) For every quote longer than one sentence, verify it uses a > blockquote,
not inline double quotes. Flag any substantial quotes that are inline.
(3) For every emotional claim or superlative ("shook me," "steadiest thing,"
"stands out"), check whether the text answers WHY, not just WHAT happened.
The explanation must provide specific evidence, not restate the claim in
different words.

AFTER ALL AGENTS REPORT.
Synthesize findings by category with counts. Before applying fixes, present
an editorial triage to the author using AskUserQuestion with two questions:

1. "Which area matters most to you?" (single-select, options dynamically
   built from categories that have findings — e.g., "Fabricated content (3)",
   "Voice violations (7)", "Filler and hype (5)")

2. "Any findings to dismiss?" (multi-select, list the top 3 most likely
   false positives with brief one-line descriptions)

The author's priority selection overrides the default fix ordering below.
Dismissed findings are skipped during revision.

Apply fixes in this priority order (adjusted by triage):
1. Fabricated content (remove any anecdotes Agent 2 flagged as manufactured,
   remove any claims Agent 2 marked fabricated)
2. Filler and hype (delete every hype reinforcement clause, break up every
   catalog tour, cut atmospheric padding identified by Agent 4)
3. Voice violations (rewrite sentences Agent 1 flagged as AI)
4. Anti-slop failures (fix each failed checklist item from Agent 1)
5. Structural issues (reorder, cut, or expand based on Agent 3)
6. Weakest sentences (address Agent 1's bottom five, lean into the top three)
7. Reader engagement (incorporate Agent 4 feedback on skippability)

Present the revised draft to the author with a brief note listing what the
editorial team found and what changed.

FOR SHORTER PIECES.
If the piece is only a few paragraphs (a quick post, a short email, a social
media thread), skip the full four-agent team. Instead, do a single self-review
pass against the anti-slop checklist above before delivering the draft.

LEARNING CAPTURE.
After the author reviews the final draft and provides feedback, capture what
this session taught. This step is what makes the skill improve over time.
Skip it only if the session produced no new learnings.

Step A — Identify learnings.
Review the full editorial session and extract learnings in three categories:

1. Patterns the author called out that agents missed or dismissed.
   These are the highest-value learnings. If the author flagged something
   as AI-speak or a bad pattern that wasn't in any agent's findings (or
   was listed as a false positive during triage), that's a gap in the
   skill's detection.

2. Patterns agents flagged that turned out to be real problems.
   If an agent's finding survived triage and the fix meaningfully improved
   the draft, record the pattern so future sessions prioritize it.

3. Vale gaps — patterns that are regex-matchable but have no Vale rule.
   Agent 1 (Voice & Authenticity Reviewer) is instructed to flag these
   explicitly as part of its anti-slop checklist. Also check: did any
   pattern come up 3+ times in the session that could be caught by a
   token list or regex?

Step B — Present learnings to the author for approval.
Use AskUserQuestion with a single multi-select question:

"Which of these learnings should I save for future sessions?" (multi-select)

List each proposed learning as an option with:
- label: Short name for the pattern (e.g., "Punchy parallel fragments")
- description: One sentence explaining what it catches and how to fix it

Include a "None — skip learning capture" option. If the author selects
that, skip Steps C and D entirely.

Step C — Write approved learnings to reference-personal.md.
For each approved learning, append an entry under the appropriate section
in references/reference-personal.md:

- Pattern learnings go under "## LEARNINGS FROM EDITORIAL SESSIONS"
- Voice pattern observations go under "## YOUR VOICE PATTERNS (WITH EXAMPLES)"
- Content-type-specific learnings go under "## EDITORIAL LEARNINGS (CONTENT-TYPE SPECIFIC)"

Each entry should include:
- A ### heading naming the pattern
- The bad example from this session (the original text before fixing)
- What was wrong (one sentence)
- The fix that worked (the revised text)
- The date and piece title for context

Before appending, read the existing file and check for duplicate entries.
If a similar learning already exists, update it with the new example rather
than creating a duplicate. A learning is a duplicate if its heading matches
an existing heading or if its description covers the same pattern.

Step D — Create Vale rules for regex-matchable patterns.
For each Vale gap identified in Step A (category 3), determine which Vale
rule type fits:

- Fixed phrases → use `extends: existence` with a `tokens:` list
- One form should be another → use `extends: substitution` with a `swap:` map
- Regex pattern → use `extends: existence` with a `raw:` list
- Count-based (too many of X) → use `extends: occurrence` with `token:` and `max:`

Create the rule file at `vale/styles/AuthenticVoice/<RuleName>.yml` following
the exact format of existing rules. Use PascalCase for the filename. Set:
- `message`: Include '%s' placeholder. Explain what it catches and suggest a fix.
- `ignorecase: true` (unless case matters)
- `level`: `warning` for behavioral patterns, `error` for hard bans, `suggestion` for judgment calls

After creating the rule file, add a corresponding entry to
references/vale-rules.md under "## AuthenticVoice rules" following the
existing format: `- **AuthenticVoice.RuleName**: [what it catches and how to fix it]`

Test the new rule by running `scripts/lint.sh` against the current draft.
If the rule produces false positives on the already-fixed draft, adjust the
token list. If it produces errors on vale startup, fix the YAML syntax.
Report the test results to the author.

Step E — Confirm completion.
Tell the author what was saved:
- How many learnings were written to reference-personal.md
- How many new Vale rules were created (with names)
- Remind them that these will be active in future sessions
