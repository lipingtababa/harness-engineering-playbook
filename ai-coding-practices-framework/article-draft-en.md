# Harness Engineering: A Practitioner's Handbook

How to organise AI and human agents for reliable software delivery

**Agents Community** | Author: Ma Gong

---

## The problem

Teams using AI coding tools are merging twice as many PRs as before. They're also spending twice as long on reviews, and shipping 9% more bugs (Dubach/DORA/GitClear, 2025-2026 data). The code is arriving faster. The ability to verify, integrate, and maintain it has not kept up.

This is a management problem. AI has made code cheap to produce. It has not made code cheap to understand, verify, or operate. The organisations that benefit from AI coding will be the ones that figure out how to absorb the increased output without letting quality degrade.

The question this article addresses: **how do you organise AI and humans so that faster code production translates into reliable delivery?**

We structure the answer into four areas: 
1. Specification (what to build) 
2. Verification (is it right)
3. Orchestration (how to organise the work)
4. Evolution (how to get better).

### Assumptions and scope

The target scenario is product engineering and business delivery, not long-cycle research and not safety-critical systems. Team size is 3-10 humans orchestrating AI agents, with moderate risk tolerance.

## Vision: Business Impact

This framework changes delivery economics in five ways:

- Faster revenue cycles: turn qualified requests into working demos in hours or days; more deals close within the same quarter.
- Higher win rate and larger deals: scope you can price and deliver with confidence; credible SLAs raise buyer trust.
- Profitable customisation at scale: per‑tenant variants as specs/rules (no forks) keep upgrades safe and bespoke work profitable.
- Predictable, low‑risk delivery: stage gates and automated verification cut rework and incidents; commitments become reliable.
- Lower cost per outcome with scalable capacity: small teams supervise many agents; throughput rises without quality drift.

---

## Execution model: agile requirements, waterfall tasks

Requirements are explored iteratively. Once a task enters execution, it moves strictly in sequence:

```
Spec → Test → Code → Accept → Deploy
```

The spec is the dividing line. Before the spec: iterate freely. After the spec: execute strictly. Tight constraints reduce error and drift. Vague processes increase context pollution.

### Stage gates

Before any code gets written, there must be machine-readable acceptance criteria: at least one end-to-end test skeleton and 2-3 core acceptance conditions. Gate 1. No exceptions.

When tests reveal ambiguity or gaps in the spec, the process goes back to the spec stage. Coding pauses until the spec is updated and reviewed. Within a stage, red-green-refactor loops are fine, but jumping across gates is not. Do not merge code without acceptance criteria.

Spikes are allowed as one-off explorations, but their output is throwaway by default. To reuse spike code, pass the gate with a spec and tests.

### Minimum operating baseline (MOB)

Four things must be in place: First, a machine-readable spec for each task, containing a task ID, context references, inputs, constraints, acceptance criteria, and non-goals. Second, at least one trophy-level end-to-end test that exercises a user-visible capability. Third, CI that runs tests on every PR, with at least one adversarial or mutation check to avoid superficial pass conditions. Fourth, a change log discipline: every PR links to the spec and skill entries it touches, and merging is blocked when tests and specs are out of sync.

---

## Pillar 1: Specification

*What are we building?*

Specs must be machine-readable operating manuals.

**Acceptance criteria are evaluation functions.** A testable definition of done that directly seeds test cases. If you can't write a test for it, the acceptance criterion is too vague.

**API contracts are trust boundaries.** Interface specifications matter more than implementation details. This is Bertrand Meyer's Design by Contract, applied to human-AI teams: define what crosses the boundary; implementation details are internal.

**Doc-testing.** [^1] Use a separate model to reason over the spec before coding. No execution; document-only checks to surface logical gaps. The method can fabricate incorrect inferences; reconcile findings with human-written acceptance criteria and write confirmed gaps back into the spec.

The bottleneck has shifted from execution speed to spec clarity. ThoughtWorks called Spec-Driven Development "the most important new practice of 2025."

Here's what a minimal machine-readable spec looks like:

```yaml
task_id: FEAT-123
context: ["/docs/arch.md#payments", "/tickets/9876"]
inputs:
  - name: amount
    type: decimal
invariants:
  - amount > 0
acceptance_criteria:
  - "Successful payment creates a billing record with amount and status=success"
  - "Failure returns a localisable error code; no billing record written"
non_goals:
  - "Instalments and refunds are out of scope"
```

The non-goals field matters more than it looks. Without it, agents may produce out-of-scope features.

### How specs fail

Specs go stale when they drift from implementation. The fix is weekly review, plus a rule that every PR must link to the spec sections it touches. Specs get ambiguous because natural language is ambiguous. The fix is to use examples, counter-examples, and boundary conditions, and to make key fields structured rather than free-text. Multiple sources conflict when there's no clear priority. The fix is a single source of truth with explicit trust rings: Ring 0 is the spec itself, Ring 1 is architecture docs, Ring 2 is design discussions, Ring 3 is everything else. When sources conflict, the lower ring wins. Scope creeps when there are no non-goals. Unrelated requirements leak in, and the agent builds them because they weren't excluded. The fix is to maintain explicit non-goals and review scope at every gate.

---

## Pillar 2: Verification

*Is it right?*

Quality has two dimensions that most teams confuse:

| Dimension | Question | Can AI automate it? |
|-----------|----------|-------------------|
| **Correctness** | Does the code work? | Yes, fully |
| **Fitness** | Is this the right product? | Partially, at best |

Most teams only verify correctness. They accumulate what Lars Janssen calls **verification debt**: tests are green, you've built exactly what the spec describes, but it turns out that's not what the customer actually wanted.

**TDD makes more sense now than it did ten years ago.** When coding cost approaches zero, the relative value of tests goes up. In a team where AI writes most of the code, the tests are the main human-authored deliverable.

**Trophy tests are the hardest to game.** These are end-to-end integration tests that exercise user-visible capabilities. If any critical sub-path fails, the whole test fails. An AI agent can easily pass unit tests by adjusting implementation to match assertions. It's much harder to fake a full user journey. This is Goodhart's Law applied to testing: when a metric becomes a target, it stops being a good metric. Integration tests are the metric that's hardest to game.

**The ground truth paradox.** AI writes the code and AI writes the tests. Kent Beck reported cases where models deleted tests to make them "pass." The fix: tests must be anchored to human-written acceptance criteria from Pillar 1, not to AI-generated code. The spec is the ground truth, not the implementation.

**Adversarial verification.** A separate agent reviews other agents' output against the spec. Think of it as a commissar role. Use a different model family to avoid correlated errors. If the coder and the reviewer share the same blind spots, the review is theatre.

Evidence: applying Deming's PDCA cycle to AI-assisted coding reduced defects by 61% in a controlled study (InfoQ, 2026). The theoretical anchor here is Ashby's Law of Requisite Variety: the diversity of your verification must match the diversity of possible errors.

### Merge rules

All correctness tests passing is necessary but not sufficient. At least one fitness signal must also be green before merging: an end-to-end metric, a real-data replay, or explicit stakeholder sign-off. If none of these are available, the merge requires a documented exemption with a reason. Cross-model verification means using models from different families or providers to check each other's work, and recording any differences along with the resolution rationale.

### How verification fails

Tests overfit implementation details when they assert on internal state rather than behaviour. The fix is behaviour-based assertions plus mutation testing or adversarial examples. Collusion happens when AI writes both the code and the tests. The fix is anchoring acceptance criteria to human-written conditions and using cross-model adversarial prompts. Regression gaps appear when bugs are fixed without companion regression tests. The rule is simple: every bug fix ships with a regression case.

---

## Pillar 3: Orchestration

*How do we organise the work?*

**Skills are job descriptions.** Each AI agent role — Coder, Reviewer, Planner — gets a skill card with explicit inputs, outputs, responsibilities, trust boundaries, and a definition of done. Here's what one looks like:

```yaml
skill: Coder
inputs: [spec.section, test.failures]
outputs: [pr.diff, test.results]
definition_of_done: ["All tests green", "PR description maps to spec items"]
trust_boundaries: ["No database schema changes", "No external API contract changes"]
failure_retry: {retries: 2, strategy: "Reduce change scope, request more context"}
escalation: "Consecutive failures → hand off to Reviewer, clarify spec"
budgets: {latency_s: 300, cost_usd: 1.5}
```

The trust boundaries matter. Without them, a Coder agent will cheerfully modify your database schema to make a test pass. The budget fields (latency and cost) prevent runaway agents from burning tokens on dead-end approaches.

**Platform engineering comes first.** Set up CI/CD, test frameworks, and monitoring before writing any business code. If the infrastructure for automated verification doesn't exist, everything in Pillar 2 is aspirational.

**Small human teams, many agents.** [^2] 3-5 humans orchestrating AI agents. Tomasz Tunguz puts the human span of control at 4-15 agents. McKinsey's data suggests 2-5 people supervising 50-100 specialised agents. You scale the span by investing in automated verification (Pillar 2), not by adding more humans.

**When to expand span of control.** Only when several conditions hold at the same time: acceptance criteria coverage is above a threshold, CI is stable with low flake rates and low false positives, the domain is stable with a controlled rate of requirement changes, and the variety of task types is bounded. If these aren't true, stay small and invest in verification automation and platform engineering first.

**Conway's Law still applies.** System architecture mirrors team structure. If you don't reorganise your team first, your AI workflows will be constrained by your old org chart.

**Iterate team composition in hours, not months.** Start with a minimal agent team. Add roles as you learn what's needed. Adjust or remove roles that don't pull their weight. Standing up or retiring an agent role costs minutes, not months of hiring. There should be someone — call it the HR function — whose job is specifically assembling and adjusting the agent team composition.

### Operational constraints

Every agent run operates within a cost and latency budget. The team needs a model diversity strategy (don't rely on a single provider). Data governance follows the principle of least necessary context: sensitive data stays out of the shared context window, and permissions and audit logging are always on.

---

## Pillar 4: Evolution

*How do we get better?*

**Standardise tacit knowledge into skills.** When someone figures out a good way to prompt, verify, or structure a task, capture it as a shared skill card. Otherwise it stays in one person's head and dies when they switch projects.

**The SECI gap.** Nonaka and Takeuchi's knowledge spiral assumes tacit knowledge transfers between sessions and between people. AI agents can't do this. They start fresh every session, with no memory of what worked last time. Skills are the engineering workaround: persistent carriers of organisational knowledge that survive across sessions. The practical discipline is to review skills weekly and require that any PR introducing a behaviour change links to the corresponding skill update.

**Double-loop learning.** Fixing bugs is the first loop. Questioning the architecture that produced the bugs is the second. Argyris made this distinction: most organisations only do the first loop. The second loop is where the real improvement happens, and it requires deliberately asking "why did our process allow this bug to exist?"

**After-action reviews.** After each agent work session, a structured 10-minute debrief. Five questions: What happened, and how did it differ from what spec and tests expected? Which assumption was wrong, and what's the evidence? What's the one behaviour to change next time? Which skill, spec, or test needs updating, and who does it when? What new regression or adversarial test case is needed?

**Without evolution, the system degrades.** AI copies patterns already in your codebase, including the bad ones. Merged code becomes the reference set for future generation. This creates a self-reinforcing quality decline. GitClear found that duplicate code blocks increased 8x after AI adoption. Anthropic's 2026 study found that developers using AI scored 17% lower on comprehension tests. Without deliberate effort to improve specs, tests, and skills, the codebase drifts toward mediocrity on its own.

---

## Cross-cutting concerns

### Context pollution: the pathology to prevent

More context does not mean better results. ETH Zurich tested 138 tasks and found that AI-generated context files produced a success rate 3% *lower* than having no context at all, at 20% higher reasoning cost. Chroma tested 18 models and found that every model's performance degraded as input length increased, even well within the token limit.

Six types of pollution:

| Type | What it is | How to fight it |
|------|-----------|----------------|
| Stale | Outdated docs, comments, architecture diagrams | Periodic cleanup, scheduled document maintenance |
| Conflicting | Multiple sources, unclear priority | Trust rings (Ring 0-3), single source of truth |
| Inferential | Cross-document reasoning errors | Flatten docs at execution time |
| Compression | Information lost during context truncation | Priority-based layering (P0-P3) |
| Collusion | AI-generated tests validating AI-generated code | Human-written acceptance criteria, mutation testing |
| Legacy | Dead code and deprecated patterns absorbed by AI | Aggressive deletion, regression tests |

The analogy is Byzantine faults in distributed systems. The AI doesn't stop working. It confidently produces wrong results.

Each type has its own detection signal. Stale pollution shows up as a rising weekly diff between spec and implementation; the fix is weekly spec audits and tombstoning deprecated docs. Conflicting pollution shows up as inconsistent requirements across sources; the fix is a single source of truth enforced in PR reviews. Inferential pollution shows up as cross-document reasoning errors; the fix is flattening context at execution time. Compression pollution shows up when long context gets truncated and drops critical information; the fix is P0/P1 priority layering with mandatory retention sets. Collusion shows up when tests and implementation share the same source; the fix is cross-model checks and mutation testing as a merge blocker. Legacy pollution shows up when agents reference deprecated APIs or dead code; the fix is scheduled dead-code sweeps and API retirement processes.

### Feedback loops: the mechanism to build

| Loop | Timescale | Function |
|------|-----------|----------|
| Inner | Seconds to minutes | Agent autonomous cycle: red-green-refactor |
| Middle | Hours to days | Human review, direction correction |
| Outer | Weeks to months | Strategic evolution, skill iteration |

The areas feed into each other: specs drive test design, test results drive pipeline decisions, observed patterns drive skill improvements, evolution updates specs. This is a closed-loop control system. Open-loop: ship code without corresponding spec/test updates and fix after failure.

Operational test for closed vs open loop: if code changes happen without accompanying spec or test changes being recorded, or if merges are based on subjective judgment alone, you're in open loop. The inner loop stops when trophy tests and acceptance criteria pass and regressions don't regress. The middle loop stops when a reviewer can map agent output back to the spec without needing additional assumptions.

---

## Where this framework is contested

This framework is not consensus. The following objections come from practitioners in the Agents community, and each one points at a real boundary.

**1. "Throw away old experience" vs "management principles still apply"**

The framework claims that management principles (Taylor, Deming, Simon) still apply to AI orchestration. Wang Jinyin takes the opposite position: you must abandon prior software engineering experience (DevOps, microservices) and recognise AI as a fundamentally new species. This is not a disagreement about degree; it tests whether prior frameworks accommodate new practices. Our response: management principles and software engineering practices are two different layers. Principles like task decomposition, feedback control, and bounded rationality are cross-domain. Practices like Scrum standups and Jira boards do need redesigning.

**2. "Layering is for humans, not for LLMs"**

Xu Keqian argued in the community that document layering helps humans organise their thinking, but LLMs should receive a flattened single document at execution time. Otherwise, cross-layer reasoning introduces errors. This directly challenges the spec layering practice. If layering is harmful at execution time, is it a design tool or an execution tool? We've incorporated this as the "inferential pollution" type, but the operational cost of "layer at design time, flatten at execution time" hasn't been validated yet.

**3. Is benchmarking a prerequisite?**

The framework implicitly assumes evaluation comes first: build the verification system, then let AI loose. Da Shi questioned this in the community: do you really need a solid benchmark before deploying AI agents? Wang Jinyin: not necessarily. In traditional organisations, IT departments can't benchmark powerful business units. The key is to spend 3 months proving capability first, earn credibility, then talk about evaluation. This highlights a gap: theory suggests evaluation first; practice often inverts the order due to power dynamics.

**4. Perception vs reality**

METR ran a randomised controlled trial and found that experienced developers using AI tools were actually 19% slower, while believing they were faster. This challenges the premise that AI increases throughput.

---

## Open questions

1. **Recursive verification.** Who watches the watchers? What's the stopping condition?
2. **Optimal context size.** Too little context means insufficient information. Too much means noise drowns signal. Where's the sweet spot? One way to test this: pick a fixed task set, run it with two context budgets (P50 and P90 length), measure success rate, round count, token cost, and defect escape rate, and report the difference with significance.
3. **Human skill atrophy.** Human judgement is declining (comprehension down 17%). AI autonomy is increasing. How long can human-in-the-loop last?
4. **Framework boundaries.** Are there practices that don't fit into these four pillars?

---

## Governance and traceability

Spec and skill versions are bound to PRs; merging generates a change record automatically. Security-critical requirements go through an additional review process. Cost and latency budgets are defined per agent role. The model and tool diversity strategy is documented. Data governance follows least-necessary-context: sensitive data does not enter the shared context window, and permissions plus audit logging are always enabled.

---

[^1]: Doc-testing concept from Xu Keqian (Agents community).
[^2]: "Three-person team" model from Wang Jinyin (Agents community, enterprise transformation practice).

---

**This article is a collective effort by the AgentsZone community.** Practices and objections all come from community discussions. The framework is still evolving. Corrections, additions, and disagreements are welcome.
