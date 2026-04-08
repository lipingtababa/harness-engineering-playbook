# Harness Engineering Playbook

## Project Structure

This is a trilingual HonKit book with content in `en/`, `zh/`, and `ja/` directories. Each language directory has the same file structure:
- `README.md` — Book introduction
- `SUMMARY.md` — Table of contents (display titles are translated, file paths stay the same)
- `chapters/` — Chapter content
- `contributors.md` — Contributor list (names are NOT translated)

`LANGS.md` at root registers available languages for HonKit.

## Translation Rules

When translating content between languages:

1. **Technical terms to keep in English across all languages**: Agent, Vibe Coding, closed-loop control, context window, TDD, CI/CD, platform engineering, Conway's Law, YOLO, PR, spec, feedback loop, open-loop control, benchmark
2. **Preserve exactly**: Markdown formatting, link targets, file paths, code blocks, image references
3. **Translate**: Heading text, body text, list items, blockquote content
4. **Do NOT translate**: Contributor names, tool names (HonKit, GitBook), project names (AgentsZone, PingCAP, TiDB, Pigsty)
5. **Chinese (zh)**: Simplified Chinese, professional tone, accessible to both technical and business readers
6. **Japanese (ja)**: Professional technical book style, です/ます form for explanatory passages
7. **English (en)**: Clear, concise, professional technical writing

## Writing Style

This book follows O'Reilly-style technical writing. All chapters in all languages must adhere to these rules:

### Tone and Language
- No flowery language. No marketing words like "惊喜", "revolutionary", "game-changing".
- No filler, no pleasantries. Get to the point.
- Use data and logic, not adjectives.
- No quotes around terms unless quoting someone directly.
- Write so the reader recognizes their own experience, not so the author narrates the reader's life. Avoid declaring what the reader feels ("你碰到了墙"). Instead, describe situations the reader will identify with.

### Sentence Structure
- No em dashes (——/—/--). Split into two sentences, or use a comma/colon. Especially avoid "主句——插入——主句" structures.
- No semicolons. Use periods or commas.
- Prefer positive assertions over negative constructions. Instead of "X is not Y", say what X actually is.
- Prefer natural paragraphs over bullet points. Use bullet points only for genuinely parallel items (lists of tools, steps in a process).

### Content Organization
- Every section needs motivation. Don't introduce a concept without first establishing the problem it solves. Content should be problem-driven, not technique-driven.
- Maintain a takeaway hierarchy: chapter takeaway → section takeaway → paragraph takeaway. Small takeaways build up to support the chapter takeaway. Without this hierarchy, the text is just listing things.
- Use 总分 structure: state the conclusion or takeaway first, then support it with evidence and mechanism. Don't use reveal/铺垫 structure where the point only becomes clear at the end of a section. Don't use setup phrases that delay information (e.g., "有一个现象特别能说明…", "考虑一个具体的情况…"). Just state the point, then give the example.
- Every piece of evidence (examples, data, mechanism explanations) must serve a specific claim. If evidence doesn't support any argument the reader currently cares about, it breaks the narrative. Move it to where it serves a claim, or cut it.
- Don't include everything that has insight. Only include material that resonates with the current section's takeaway.
- Distinguish principle from practice. Principles (why something works) belong in methodology sections. Practices (how to do it) belong in operational sections. Don't mix them.
- Don't repeat what earlier chapters already established. Reference earlier conclusions and build on them.
- When writing parallel sections (e.g., multiple characteristics, multiple case studies), vary the internal structure. If every section follows the same pattern (problem → mechanism → consequence → same-style closing), the rhythm becomes predictable and the reader disengages.
- This is a teaching book, not a survey. Frameworks and case studies serve as evidence for principles, not as parallel exhibits. Avoid comparison tables across multiple frameworks.
- Don't present problems as unresolved if solutions exist in the community. The book should present principles with case support, not reflections on gaps.

### Concept Framing
- Extract principles from implementations. The book teaches principles that readers apply in their own context, not specific tools to copy.
- When a concept belongs to another domain (e.g., product management's user story methodology), reference it as common sense and note its relevance to Agent development, but don't teach the domain itself.
- Human's role in Agent development is not that humans are "better at" certain tasks. It's that certain judgments (intent alignment) can ONLY be made by humans because intent exists only in the human's mind.

### Writing Workflow
- Write one section at a time. Writing the whole chapter at once produces outline-level prose.
- After completing a chapter draft, run `/review-writing <file-path>` for 2-3 rounds of self-review before presenting to the user. First drafts consistently violate writing rules even when the rules are known; iterative self-review catches the majority of structural issues.

## Build

```bash
npm install
npm run serve   # local dev server at localhost:4000
npm run build   # build to _book/
```
