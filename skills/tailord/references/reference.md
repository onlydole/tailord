# Writing Reference
Deep reference material for drafting and editorial review. Load this file
when you need richer context for voice decisions, technique selection, or
understanding what makes specific writers' approaches work. This supplements
voice.md (the rules) with examples, profiles, and patterns.

WRITER PROFILES - TECHNIQUES TO DRAW FROM:

The Open-Source Diarist.
Personal anecdotes with specific details, not abstract principles. Shows
rather than tells with actual screenshots, commands, and code. Admits
limitations openly. Links extensively, treating the web as a network. Uses
direct reader address: "You may have noticed..." instead of "A new
convention is emerging..." Writing has "texture, quirks, and authenticity."
Formats: annotated presentations, TIL (Today I Learned) short notes,
long-form analysis, link commentaries.

The Calm Practitioner.
Signature move: Diagnosis-Policy-Implementation. Nearly every post follows:
(1) diagnosis of what's actually wrong as concrete observations, (2) policy
principles that should govern the response, (3) implementation of specific
actions taken. Reports from inside the work, not above it. Authority through
specificity: "I renamed three channels and deleted the unused ones."
"This took approximately eight hours." Names real companies and real people.
Uses "approximately" for own measurements, signaling honest recall rather
than false precision. Plain-description titles, often fragments: "Migrated
the build system to Bazel." Ends when the content ends. No summary, no
call to action.

The Metaphor Architect.
Signature move: Sustained metaphor as organizational architecture. Doesn't
use metaphors as decoration; builds entire articles around them. A single
pop culture reference structures the whole piece. The metaphor IS the
article. Wide emotional dial within a single piece: gonzo enthusiasm to
genuine vulnerability to biting sarcasm within paragraphs. Build-up-then-
puncture rhythm: bold claim, then self-deprecation, then bolder claim.
Self-deprecation as credibility tool: mocking own work inoculates against
criticism and earns permission for bold claims. Confidence comes first; the
qualifier reads as intellectual honesty, not hedging. Writes like a
brilliant friend ranting at a bar. Pop culture references as load-bearing
structure, not decoration. Length without apology. Swerve transitions: a
technical analysis ends abruptly, the next section opens with a personal
anecdote. Ends with personal commitment: "I'm making sure..."

The Pattern Namer.
Signature move: Naming the unnamed. Where others describe problems, this
writer gives them handles. "The scattered leader." "The deployment
bottleneck." "Minimum effective dose of coding." Naming makes abstract
problems concrete, gives readers vocabulary, and makes writing quotable.
The trusted senior colleague, not a guru. Scenario-painting with "imagine."
Exactly one external framework per article. Brings in one scaffold, explains
it, applies it. The inversion technique: asks "how would you guarantee
failure?" rather than listing what to do. Section headers as intrigue: "The
courage to subordinate" instead of "Why subordination requires courage."
Ends with "Your turn" and a direct exercise.

The Essayist.
Blend of wit, sarcasm, and erudition. Footnotes and asides for context
without breaking flow. Explains not just "what" but "how" and "why."
Long-form essays mixed with brief linklog commentary. Strong opinions
clearly stated, not falsely balanced.

The Investigative Reporter.
Deep reporting with insider sources. Shows the work: interview quotes, data,
methodology. Long-form investigative pieces that take weeks to research.
Reader questions drive content.

The Minimalist.
Radically concise. Every word earns its place. Live demos over slides.
Honest about limitations of tools they advocate. Practical focus: how does
this help someone get work done?

AI WRITING TELLS:

Vocabulary tells. Words that spiked 50%+ after ChatGPT: delve, robust,
pivotal, comprehensive, crucial, vital, leverage, foster, underscore,
streamline, elevate, harness, meticulous, multifaceted, nuanced, realm,
tapestry, landscape, journey. Overused transitions: moreover, furthermore,
indeed, in conclusion, overall, "it's worth noting," "importantly."
Unnecessary intensifiers: "actually," "really," "very," "just." If removing
the word doesn't change the meaning, remove it. Phrases that scream AI:
"In today's fast-paced digital world," "plays a significant role in
shaping" (207x more common in AI), "stands as a testament," "unlock the
secrets."

Structural tells. Negation openers ("It's not just X, it's Y") appear in
almost every AI first paragraph. Summary intros ("In this post, I'll
explore..."). Summary conclusions ("In conclusion, by doing X, we can Y").
"Question? Answer." pattern ("The best part? It's this."). Rule of three
abuse: AI loves triplets. Rigid intro/bullet/conclusion format. Excessive
signposting: "Here's the key takeaway," "The most important thing is."

Style tells. Low burstiness: AI creates medium-length sentences that all
sound similar. Staccato assertion patterns: "Short. Punchy. Fragments."
(sounds dramatic but reads as breathless). Name-dropping without context
(listing examples without explaining why they matter). Short sentence pairs
that should be combined. Passive voice where active is clearer. Lack of
concrete details. Overly positive/neutral tone (human text has stronger
negative emotions). The chain of three: "X means Y. Y means Z. Z means W."

The vibe check. AI text says all the right things in all the right order
and still leaves you feeling nothing. Humans ramble, contradict, meander,
and drop tangents. The difference isn't grammar, it's guts.

SHOW, DON'T TELL:

Never tell readers how to feel. "This is the annoying thing about X" robs
the reader of reaching that conclusion. Instead, describe X so vividly the
reader feels annoyed without being told. "The frustrating part is that the
failure is silent" becomes "The failure is silent. The agent doesn't throw
an error. It just does the wrong thing with complete confidence."

Trust the reader with evidence and let them reach the verdict. Use sensory
details, strong verbs, and dialogue. Telling is acceptable for minor
characters, glossing over uneventful periods, necessary backstory, and
technical explanations requiring precision.

ADVANCED RHETORICAL TECHNIQUES:

Sustained metaphor as architecture. Don't use metaphors as decoration.
Build the article around one. Weak: "Documentation cleanup is like spring
cleaning." Strong: the entire article uses spring cleaning as the organizing
frame (rooms are teams, closets are wiki spaces, the "junk drawer" is the
inbox). Pick metaphors from outside software.

Naming the unnamed. When you identify a pattern that lacks a name, give it
one. Unnamed: "When a leader tries to fix everything simultaneously, they
make partial progress on everything and complete nothing." Named: "The
scattered leader fights every battle and wins none." Naming makes the
abstract concrete and makes your writing quotable.

The inversion technique. Instead of listing what to do, describe what
guarantees failure. Direct: "To stay relevant, keep coding and learn new
tools." Inverted: "Four rules for guaranteed obsolescence: stop writing code
entirely, dismiss every new tool as a fad, delegate all technical decisions,
never attend a technical talk."

The time estimate. Ground your work in how long things actually took.
"Altogether, this was about eight hours of my time, but required zero hours
of anyone else's." Signals accessibility, efficiency, and credibility
simultaneously. AI writing almost never commits to time estimates.

Confidence-vulnerability oscillation. Make bold claims, then immediately
show your uncertainty. Flat: "AI coding has reached a tipping point. Here's
why." Oscillating: "AI coding hit a turning point last month. It's the real
deal. I know some of you respectfully disagree." Bold claim first,
vulnerability after.

The "Your turn" handoff. End by handing the framework to the reader with a
specific exercise. "Spend five minutes thinking about your team, your
department, and your company. At each level, write down what you think the
biggest bottleneck is." Avoids the summary paragraph. Transforms passive
reading into active thinking.

THE CURRENT WRITING LANDSCAPE:

Readers no longer want tutorials. AI can generate those. What readers pay
for is sense-making: help understanding what is happening and what it means
for them. Write to give people a framework for understanding, not a
checklist for executing.

Consumer preference for AI-generated content has dropped sharply. Having a distinctive, unmistakable voice is the
single biggest competitive advantage. Learning in public beats presenting
expertise. Concrete specifics anchor everything. Emotional range within
technical content is a distinctly human move. Named patterns and sticky
frameworks give readers vocabulary. An opinionated frame (what I think
about what is happening, and why) is THE differentiator from AI summaries.

Platform-aware writing. Substack rewards intimacy, opinion, relationship.
Write like a letter to someone who already trusts you. Medium favors
discovery and SEO. Personal blogs reward deep expertise and distinctive
voice. Hacker News rewards surprising depth and showing the work.

The anti-AI content premium. Your human voice, messiness, vulnerability,
and contradiction are premium signals. Don't sand them away. The most-shared
posts about AI tools are written in deeply personal, clearly-human voices.

---

For personal voice patterns, editorial learnings from past sessions, and
narrative flow examples from published work, see `reference-personal.md`
(create from `reference-personal.template.md` if it doesn't exist).
