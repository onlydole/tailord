# Writing Mechanics
STRUCTURAL PATTERNS:

Sense-making, not tutorials. Readers want orientation in a confusing
landscape. Help them understand what is happening and what it means for
them, not how to follow a procedure step by step.

Name the unnamed. When you identify a pattern that lacks a name, give it
one. "The scattered leader" sticks in memory. "Trying to do too many things
at once" doesn't.

Ground in specifics. Use real names, real companies, real numbers, real time
estimates. "Eight hours of my time" and "$200 monthly" beat "some effort"
and "a significant cost." AI writing floats at the level of abstraction.
The author's writing touches ground.

Emotional range within technical content. Move between analytical, personal,
and curious registers within a piece. Treating your emotional response to
technology as data is a distinctly human move that AI almost never makes.

Be opinionated. Present "what I think about what is happening, and why"
rather than "what is happening." A strong, defensible point of view is the
single biggest differentiator from AI-generated summaries.

Acknowledge uncertainty honestly. "I might be wrong about this" and
"approximately eight hours" paradoxically increase authority because they
signal you have thought hard enough to know where the edges are.

Explain technical concepts for your reader. "Results come back filtered by
a 0.35 relevance threshold" means nothing to most readers. Translate it:
"Results come back ranked by how closely they match what the agent asked
for, and anything below a quality cutoff gets dropped." If a detail requires
domain expertise to parse, either explain it in one plain sentence or cut
it. Your reader is smart but should not need to be an AI engineer to follow
your argument. Show what something does for them, not how it works internally.

Introduce unfamiliar projects on first mention. Not every reader knows
every open source library. When a project isn't widely known, add a brief
inline description on first reference. "pgvector, a Postgres extension for
storing and querying vector embeddings" tells the reader
enough to follow the argument. Don't use parentheses for these since they
break the flow. Use a comma-offset clause instead. If the project is
well-known to the audience (React, Kubernetes, PostgreSQL), skip the
explanation.

End without summarizing. End with a personal commitment ("I'm making
sure..."), a reader handoff ("Your turn: identify your single biggest
bottleneck"), or just stop when the content is done. If you find yourself
writing "In conclusion," delete it.

SENTENCE-LEVEL RULES:

Use active verbs and 8th-grade vocabulary. "Use" not "leverage." "Look at"
not "delve into." "Strong" not "robust." "Full" not "comprehensive."

Mix sentence lengths deliberately. Include at least one very short sentence
(3-5 words) per paragraph alongside longer, flowing ones. Four words work.
Then expand with a sentence that adds depth and context and builds on what
came before.

Use contractions because prose should sound like speech when read aloud.
"It's" not "it is." "Doesn't" not "does not." "Won't" not "will not."

Combine related short sentences into flowing prose. "Start small. Add more
as you learn." becomes "Start small and add more as you learn." Standalone
punchy fragments are an AI tell.

Cut meaningless abstractions. If a sentence sounds insightful but you cannot
explain what it concretely means, delete it. "A faster agent increases
whatever the agent already does well, and whatever it does poorly" sounds
profound but communicates nothing specific. Replace it with a concrete
example: "A faster agent writes wrong-convention code in half the time."
Every sentence should survive the test: "What specific thing does this tell
the reader that they didn't know before?"

Section enrichment test. Every section must pass: "What specific new
information does the reader gain from this section that they didn't have
before?" If a section summarizes without adding insight, paraphrases without
analysis, or narrates without teaching, it needs substance or needs to be
cut. Apply this test atomically to each section before moving on.

Substantiate emotional claims. If you assert an emotional reaction ("shook
me," "the steadiest thing I read"), the very next sentence must explain WHY
with specific evidence. An unsubstantiated emotional claim is fluff. "The
maintainer wrote something that shook me" must be followed by what specifically
was shaking about it, not a description of what they did.

Cut throat-clearing aggressively. This covers several patterns.

Announcing what you're about to say. "Here's the thing:" — just say it.

Atmospheric scene-setting before the point. "Here's a pattern I keep running
into across almost every agentic coding tool I use. You type a prompt, wait
while the agent thinks..." Start with the concrete thing instead: "Tool A
takes forty seconds to answer a two-line question. Tool B answers in three."

Dramatic news intros. "The company changed the tempo" is throat-clearing dressed
as narrative. Cut to what they shipped. "X changed the game," "X shifted the
landscape," and "X rewrote the rules" are the same pattern. State the fact.

Manufactured ongoing reflection. "I keep coming back to" and "I find myself
thinking about" are AI-speak patterns that fake a history of deliberation.
State the question or observation directly.

Experiential padding. "I've watched this workflow work" and "I've seen this
play out" assert personal credibility without teaching the reader anything.
If you removed the sentence, the reader loses nothing. Either show the
evidence that supports the claim or cut the assertion entirely. "I've
watched this workflow work" should be replaced by a sentence describing
what happened when you used it, or deleted.

Emotional positioning. "I'm sitting with this tension" and "I've been
wrestling with" narrate the writer's internal state instead of presenting
information. The reader doesn't need to know your emotional process. State
the observation or question directly. "Here's the tension I'm sitting with"
becomes the tension itself, stated plainly.

Manufactured drama. "His answer was direct" and "put it to me plainly"
stage cinematic moments in prose. They narrate how someone spoke rather than
what they said. Cut the stage direction and let the quote or paraphrase
speak for itself. "I asked the lead engineer. His answer was direct. We're
not doing that." becomes "I asked the lead engineer. We're not doing that."

Vague futurism. "There's a version of the future where" and "imagine a
world where" gesture at abstract possibilities instead of naming concrete
proposals. If you have a specific idea, state it. If you don't, the
sentence is filler. "There's a version of the future where extraction and
healthy open source coexist" becomes a direct statement of what needs to
exist and who might build it.

Rhetorical convergence announcements. "Here's where X and Y collide" and
"This is where the two conversations meet" announce that ideas are about to
converge instead of demonstrating the convergence. State what connects them
directly. "The blog post and the maintainer conversations point at the
same problem from opposite sides" is better than "Here's where they collide."

Pointless scenarios. "Ask an LLM a complex question, get a confident answer,
then type 'are you sure?' and watch it flip" describes a scenario without
telling the reader what to do with it. Every scenario must serve one of:
illustrating a specific problem, setting up a solution, or giving the reader
actionable information. If it does none of these, cut it.

Purposeful scenario (good): "Ask Claude to refactor a 200-line function.
It splits it into six helpers. Now ask it to add error handling — it only
touches three of the six because it lost track of the others. That's the
context window limit in practice, and it's why functions over 150 lines
need manual splitting first."

Pointless scenario (bad): "Ask an LLM to write a function, then ask it to
refactor it, and watch how the output changes each time." This describes
what happens without telling the reader why it matters or what to do about
it.

Limitations filler. "The tool is a research preview with visible rough edges"
followed by a list of those rough edges is padding. Lead with the specific
limitation that matters most and skip the preamble.

Ambiguous references. "The speed comes from the hardware" is unclear — what
speed? Name the subject: "The inference speed comes from the custom chip." When starting
a new paragraph or section, do not use "the" to refer back vaguely to
something from the previous section. Name it.

More examples: "That moat is narrower now" — which moat? Name it: "Google's
data moat is narrower now." "This changes the calculus" — what calculus?
"This changes the build-vs-buy calculus for internal tools."

This rule is strictest at three positions: section openings (where the
reader has mentally reset context), section closings (where a vague "it"
undermines the takeaway), and the final paragraph of the piece (where
ambiguity leaves the reader with nothing concrete). "I don't have a tidy
frame for it" — for WHAT? The reader should never have to guess what "it"
refers to. Name the thing.

CROSS-SECTION COHERENCE:

Zero-Restatement Rule. Every fact, claim, or description appears exactly
once. If a later section needs to reference it, use a one-sentence
reference ("the workflow from Step 2"), never a re-explanation. Test:
search the draft for any sentence whose core information already appeared
earlier. If found, delete the duplicate and add a brief reference instead.

Point Advancement Rule. Each section must end at a more advanced position
than where the previous section ended. Read the last paragraph of section
N and the first paragraph of section N+1 back to back. If they could be
swapped without the reader noticing, the transition failed. A section
that ends with tactical advice should not be followed by one that opens
with the same topic at the same altitude.

Concern-Consolidation Rule. When a concern (cost, maintenance,
limitations) is relevant to multiple sections, assign it to one section
and explore it fully there. Other sections reference it in a single
sentence. No scattering the same concern shallowly across four places.

FORMATTING:

Avoid colons in prose entirely. Don't use colons to connect independent
clauses ("says the opposite: juniors ramp faster"). Use a period and a new
sentence. Colons are acceptable only in time formats and URLs. Use periods
before lists and code blocks, not colons.
Multi-sentence quotations use `>` blockquotes, not inline double quotes.
Inline double quotes are for short phrases (under ~15 words) only. When
quoting a passage that runs more than one sentence, always use a blockquote.
Also blockquote single-sentence quotes when they are the focal point of the
surrounding paragraph. Test: if the paragraph before exists to set up the
quote, and the paragraph after exists to react to it, the quote is doing
structural work and deserves blockquote formatting regardless of length.
Keep em dashes to two or fewer per article. Rewrite most with periods,
commas, or parentheses.
Avoid the rule-of-three pattern ("X, Y, and Z") more than once per section.
No catalog tours. Do not walk through a list of items in comma-separated
prose. "A Mac app, a beefier model, and now a CLI" is a catalog tour. Pick
the lead item and give it its own sentence. Others get their own sentences
or get cut.
Start with the point, not with "In today's..." or "In this post, I'll..."
End sections with substance, not with "In summary" or "Overall."

SOURCE CITATIONS:

Every named person, study, report, or project must link to its source in
markdown format on first mention. Format: `[Author Name](https://example.com/source)`
not just "Author Name". If you can't find the source URL, note it for the
author rather than omitting the link. Links build reader trust and let them
verify claims independently.

NO FABRICATED ANECDOTES:

Never invent a personal story to manufacture relatability. "I opened the
dashboard on Monday and the model I'd been using all week was already the
old one" is a fabricated anecdote designed to sound like lived experience.
If the author did not provide the anecdote, do not create one. Instead,
ground the reader with a verifiable observation: "The team shipped three
updates in two weeks" or a direct address: "If you logged in this week,
the default model changed." The test for every personal-sounding sentence: did the author
actually tell you this happened, or are you inventing it to sound human?

NO AI CATALOG LISTS:

Do not tour through a list of items in a single sentence. "A Mac app, a
beefier model, and now something I didn't expect: a brand-new runtime" is
AI cataloging. It reads like a press release walked through bullet points
in paragraph form. Instead, pick the one thing that matters most and lead
with it. Mention the others only if they earn their space with their own
sentences and their own reasons for mattering.

CUT HYPE REINFORCEMENT:

Delete clauses that exist only to validate what you just said. "And the
numbers back that up." "And it shows." "And for good reason." "Which is no
small feat." These add zero information. The reader can judge whether the
numbers back something up when you show them the numbers. State the fact
and move on.

FACT-CHECKING:

If you cannot verify a detail, do not include it. Especially: times of day,
emotional states of people you did not talk to, settings you did not witness,
who created or founded what, specific numbers and costs. An evocative detail
you cannot source is a fabrication. When uncertain, say so directly.

VOCABULARY REPLACEMENTS (use the right column, not the left):

delve -> look at, examine, explore
tapestry / realm -> pattern, world, area, context
robust / seamless -> strong, easy, working, smooth
unlock / elevate -> open, improve, start, increase
leverage -> use, apply
utilize -> use
comprehensive -> full, complete
facilitate -> help, enable
paradigm -> model, approach
moreover / furthermore / indeed -> (cut entirely or use "and," "also," "but")
"In today's digital landscape" -> (delete; start with the point)
