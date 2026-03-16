# Framework: How to Organise AI and Human Agents for SDLC

> Core question: How do you organise AI and human agents to deliver software reliably?

> Thesis: AI coding is not a tooling problem, it's a management problem — organising agents for outcomes.

> Structure: One question, four pillars, cross-cutting concerns

---

## The Question

93% of developers use AI coding tools. Productivity gains: 10%. PR merges +98%, but PR review time +91%, bug rate +9%.

Goldratt's Theory of Constraints explains why: AI accelerated the cheapest part of software development (writing code) and did nothing for the expensive parts (design, review, debugging, deployment, maintenance).

The bottleneck is not speed. It's clarity. It's organisation. It's management.

**One question: How do you organise AI and human agents to deliver software reliably?**

---

## Four Pillars

### Pillar 1: Specification — What to build

Define the work so any agent (AI or human) can execute it without ambiguity.

**Key practices:**
- PRD as machine-readable instruction set (not human-readable document)
- Acceptance criteria as evaluation functions (not communication tools)
- API contracts as trust boundaries (Design by Contract)
- Doc testing: AI runs a thought experiment against the spec before any code is written (胥克谦)

**Core insight:** Spec-Driven Development is "the most important new practice of 2025" (ThoughtWorks). The spec is not bureaucracy — it's the AI's operating manual.

**Theoretical anchor:** Taylor's job description → PRD. The constraint is now clarity, not execution speed.

**Materials:** `five-layer-model-definition.md` (Layer 1), `doc-testing-thought-experiment.md`, `community-neologisms-2025-2026.md` (SDD)

---

### Pillar 2: Verification — How to know it's right

Ensure quality at every stage through testing, adversarial review, and feedback loops.

**Key practices:**
- TDD revival: AI writes code cheaply, so testing's relative value skyrockets
- Trophy Testing Model: integration tests are hardest for AI to game (Goodhart)
- Adversarial verification: commissar role, red team, cross-model validation
- Regression testing: the safety net without which AI iteration = chaos
- Human in the loop at decision points, not reviewing everything

**Core insight:** Two dimensions of quality — Correctness (does the code work?) is automatable; Fitness (is the product right?) requires human judgement. Most teams only verify correctness and accumulate Verification Debt on fitness.

**The paradox:** AI writes code + AI writes tests = collusion (Ground Truth Problem). Solution: humans anchor tests in acceptance criteria (Pillar 1), not in AI-generated code.

**Theoretical anchor:** PDCA cycle (61% defect reduction in controlled study). Ashby's Law of Requisite Variety — your verification must be at least as diverse as the errors AI can produce.

**Materials:** `quality-correctness-vs-fitness.md`, `feedback-loop-concept.md`, `community-neologisms-2025-2026.md` (Verification Debt, Cognitive Debt)

---

### Pillar 3: Orchestration — How to organise the work

Design the workflow, team structure, and delegation model for AI + human collaboration.

**Key practices:**
- Skills as job descriptions: each skill has clear input, output, responsibility boundary
- Subagent delegation: same principles as management delegation — clear brief, verification on completion
- Pipeline design: platform engineering first — build the feedback infrastructure before writing business code
- Team structure: 3-5 person cells (王津银), hour-cycle team building (not month-cycle)
- HR role: someone dedicated to assembling and iterating the agent team

**Core insight:** Conway's Law applies — system architecture mirrors team structure. Restructure the team first, or the workflow will be constrained by the old org. The difference: human teams adjust monthly, AI teams adjust hourly.

**The constraint:** Span of control is 4-15 agents per human manager (Tunguz). The goal of orchestration is to expand this through automated verification (Pillar 2), not through more humans.

**Theoretical anchor:** Herbert Simon's Bounded Rationality (context window = cognitive capacity). Delegation theory (DeepMind 2026). VSM Systems 1-3.

**Materials:** `five-layer-model-definition.md` (Layer 3), `team-building-iterative.md`, `wangjinyin-agentic-enterprise-transformation.md`, `platform-engineering-first.md`

---

### Pillar 4: Evolution — How to get better over time

Build organisational learning so the system improves with every iteration.

**Key practices:**
- Skill standardisation: from personal tacit knowledge to shared explicit knowledge
- Iterative team building: start simple, accumulate experience, adjust roles
- Double-loop learning (Argyris): not just fixing bugs, but questioning the architecture that produced them
- After Action Review: structured retrospective after each agent work session
- Knowledge persistence: bridging the SECI gap — agents lose memory across sessions, skills are the durable carrier

**Core insight:** The SECI knowledge spiral breaks with AI — agents can't retain tacit knowledge across sessions. Skills are the engineering solution to this organisational memory problem.

**The risk:** Without evolution, the system calcifies. AI reproduces patterns from the codebase, merged code becomes the reference set, quality degrades in a positive feedback loop. GitClear: 8x increase in duplicated code blocks after AI adoption.

**Theoretical anchor:** Senge's Learning Organisation. Nonaka & Takeuchi's SECI model. Kaizen (continuous improvement).

**Materials:** `management-theory-validation.md` (SECI, Org Design), `paradoxes-management-ai.md`, `community-neologisms-2025-2026.md` (Skill Atrophy)

---

## Cross-Cutting Concerns

Two mechanisms that weave through all four pillars:

### Context Pollution — the pathology to prevent
- More context ≠ better results (ETH Zurich: -3%, Chroma: universal degradation)
- Six types: stale, conflict, inference, compaction, collusion, legacy
- Byzantine Fault analogy: AI doesn't crash — it confidently produces wrong results
- Each pillar has its own pollution risk (spec staleness, test collusion, compaction loss, skill decay)

### Feedback Loops — the health mechanism to build
- Open-loop (vibe coding) → closed-loop (TDD + CI + review)
- Three loops: Inner (seconds-minutes, agent autonomy), Middle (hours-days, human review), Outer (weeks-months, strategic evolution)
- Pillar 1→2: specs drive test design. Pillar 2→3: test results drive pipeline decisions. Pillar 3→4: observed patterns drive skill improvement. Pillar 4→1: evolution updates specs.

---

## Writing Notes

- **Data must be sourced**: 93%/10% (Dubach/DORA), 61% (InfoQ PDCA), 17% (Anthropic 2026), 3% (ETH Zurich)
- **No fabricated cases**: community cases from real chat data, attributed
- **Tone**: analytical, calm, evidence-first — "let's investigate together"
- **Theory anchor**: VSM as primary, but pillars are the user-facing structure
