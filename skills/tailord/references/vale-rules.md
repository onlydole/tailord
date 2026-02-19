# Vale Rule Handling Guide

Per-rule guidance for fixing vale findings from the AuthenticVoice and Google style packages.

## Google rules

- **Vale.Spelling**: Technical terms (product names, frameworks, APIs) trigger spelling errors. Add new terms to the accept list at `vale/styles/config/vocabularies/AuthenticVoice/accept.txt` (one term per line, alphabetically sorted). Re-run vale after updating.
- **Google.FirstPerson** and **Google.We**: Disabled in `vale/.vale.ini` because the author's blog voice is first-person by design. If vale is ever used for docs or other non-blog content, re-enable these per-glob (e.g., `[docs/**]`).
- **Google.Colons**: Can false-positive on ": I" constructions. Ignore when "I" follows a colon since English always capitalizes "I".
- **Google.Parens**: Ignore for standard acronym definitions like "Model Context Protocol (MCP)" and deliberate stylistic choices in titles.
- **Google.Acronyms**: Spell out unfamiliar acronyms on first use with the full form followed by the abbreviation in parentheses. Well-known developer acronyms (API, CLI, SDK, REST, etc.) are already in the exceptions list. Add new common acronyms to `vale/styles/Google/Acronyms.yml` as needed.
- **Google.Headings**: Downgraded to `suggestion` in `.vale.ini` so quoted or creative headings don't block the lint pass. Uses sentence-style capitalization. Product names and acronyms that appear in headings must be in the exceptions list in `vale/styles/Google/Headings.yml`. Add new ones as needed.
- **Google.Passive**: Fix passive constructions by identifying who is doing the action and making them the subject. "The module was rewritten" becomes "your team rewrote the module."

## AuthenticVoice rules

- **AuthenticVoice.NegativeParallelisms**: Rewrites like "not just X" or "not only X" trigger this. Rewrite using "rather than", restructure the sentence, or make a direct positive statement instead.
- **AuthenticVoice.CondescendingAssumptions**: Words like "just", "simply", "obviously" get flagged. For "just" meaning "recently" (e.g., "it just shipped"), drop the word since the tense already conveys recency. For "just" meaning "only" (e.g., "doesn't just modify"), rewrite the contrast differently.
- **AuthenticVoice.ExperientialPadding**: Sentences that assert personal experience as validation without teaching the reader anything ("I've watched this workflow work," "I've seen this play out," "I can confirm"). Either show the evidence (what happened when you used it?) or delete the sentence entirely.
- **AuthenticVoice.ManufacturedDrama**: Phrases like "his answer was direct" or "put it to me plainly" stage a cinematic moment. State what the person said without narrating how they said it. Replace "I asked the lead engineer. His answer was direct. We're not doing that." with "I asked the lead engineer. We're not doing that."
- **AuthenticVoice.VagueFuturism**: Phrases like "there's a version of the future where" or "imagine a world where" gesture at abstract futures instead of naming specifics. Replace with a concrete proposal or cut the preamble and state what needs to exist.
- **AuthenticVoice.EmotionalPositioning**: Phrases like "I'm sitting with" or "I've been wrestling with" narrate internal states as atmospheric padding. State the observation or question directly instead. "Here's the tension I'm sitting with" becomes the tension itself.
- **AuthenticVoice.RhetoricalScaffolding**: Includes "Here's where," "This is where," "That's where" transition patterns. These announce a convergence instead of demonstrating it. Rewrite to state what converges directly: "The blog post and the maintainer conversations point at the same problem" rather than "Here's where they collide."
- **AuthenticVoice.FloaterSentences**: Sentences like "That shift changed which tools I reached for" or "I'm still figuring out how much visibility I need" that narrate process without teaching the reader anything. Either add substance (what shifted? what are you figuring out?) or cut the sentence.
- **AuthenticVoice.TransitionFormula**: The "stops being X and starts Y-ing" construction is a strong LLM tell. Rewrite the contrast directly instead of using this formula.
- **AuthenticVoice.FabricatedExperience**: Phrases like "I keep bumping into" or "the thing that struck me watching" construct experiences the AI hasn't had. Ground in a specific real event or cut.
- **AuthenticVoice.EmotionDirectives**: Phrases like "the frustrating part is" or "what's fascinating is" tell readers how to feel. Describe the situation vividly enough that the reader reaches the emotion themselves.
- **AuthenticVoice.QuoteFraming**: Phrases like "put it well" or "summed it up" are throat-clearing before quotes. Let quotes speak for themselves.
- **AuthenticVoice.VerdictBeforeEvidence**: Phrases like "That's powerful" or "is worth trying" deliver the verdict before showing why. Flip the order: evidence first, then let the reader conclude.
- **AuthenticVoice.UseContractions**: Flags uncontracted negatives ("do not", "does not", "cannot") since blog prose should sound like speech. Fix by contracting ("don't", "doesn't", "can't"). Ignore in direct quotations or when emphasis is intentional.
- **AuthenticVoice.LimitationsPreamble**: Generic limitation setups like "isn't without its limitations" or "faces several challenges." Lead with the specific limitation instead.
- **AuthenticVoice.ConjunctiveOveruse**: Formal transitions like "In addition," "Consequently," "Nevertheless," that signal AI in blog prose. Use simpler connectors or restructure.
- **AuthenticVoice.SocialProofPadding**: Popularity metrics like "went viral" or "top of Hacker News" as proof of value. Show what people learned or built instead.
- **AuthenticVoice.CredentialListing**: Credential assertions like "with over X years of experience" or "is a renowned expert." Show what the person built or shipped that makes their perspective matter.
- **AuthenticVoice.UnsubstantiatedEmotions**: Either add the WHY in the next sentence or cut the emotional claim entirely. The reader needs evidence, not the writer's feelings.
- **AuthenticVoice.UnsubstantiatedSuperlatives**: Show evidence before or immediately after the superlative. "The steadiest thing I read" must be followed by WHY it's steady.
- **AuthenticVoice.ColonSplice**: Replace the colon with a period and start a new sentence. Ignore for time formats (10:30), URLs, and code syntax.
- **AuthenticVoice.RestatementSignals**: Phrases like "essentially, we're going to," "in other words," "as mentioned earlier" signal that you're restating information that already appeared. Delete the restatement and add a brief reference to where the information first appeared instead.
- **AuthenticVoice.SectionResetOpeners**: Section openings like "Now that we've covered," "With that in place," "So far we've" recap the previous section instead of advancing. Open with the new section's point directly.
