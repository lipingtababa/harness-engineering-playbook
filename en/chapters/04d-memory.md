# Session Over, Where Did the Knowledge Go: Cross-Session Memory Engineering

Task decomposition means a complex project will span multiple sessions. Each time a session ends, the context window is cleared and the Agent's entire working memory resets to zero. The next session starts from a blank slate.

Without a memory mechanism, you need to re-explain the project background, current progress, design decisions already made, and pitfalls already encountered to the Agent at the start of every session. This repetitive information transfer is both time-consuming and unreliable, because you may omit certain critical details, and these omissions will cause the Agent to repeat the same mistakes.

Skill cards are the core vehicle for solving this problem. Each Agent role is equipped with a Skill card that records the persistent information it needs to know. A minimal Skill card contains the following structure:

```
skill: Coder
inputs: [spec.section, test.failures]
outputs: [pr.diff, test.results]
definition_of_done: ["All tests green", "PR description maps to spec entries"]
trust_boundaries: ["Do not change database schema", "Do not modify external API contracts"]
failure_retry: {retries: 2, strategy: "Narrow change surface + request more context"}
escalation: "On consecutive failures, escalate to Reviewer and return to spec for clarification"
```

Skill cards persist across sessions. They serve the function of tacit knowledge carriers in traditional teams. When a new session starts, the Agent loads its corresponding Skill card and immediately obtains its role definition, work boundaries, known handling strategies, and historical lessons. It does not need to start from zero understanding what it should do, what it can do, and what it cannot do.

Beyond role-level Skill cards, project-level knowledge persistence is also needed. Knowledge capture at the end of each session is a critical step: what decisions were made in this session? What new constraints were discovered? What pitfalls were hit? This information needs to be recorded in a structured way and become input for the next session.

An effective approach is to conduct a brief retrospective at the end of each session: what happened? How did outcomes differ from spec and test expectations? Which assumption was wrong? Which Skill card or spec needs updating? The answers to these questions are captured and written back to the Skill cards or the specification system.

Skill cards themselves also need to evolve. As the project progresses, the Agent's role boundaries may shift, new constraints are discovered, and better handling strategies are validated. A Skill card is not a configuration file written once and fixed forever; it is a continuously updated knowledge carrier. When a PR introduces behavioral changes, the corresponding Skill card should be updated in sync. This is the concrete practice of the evolution principle at the knowledge level.

The goal of memory engineering is to make the Agent's hundredth session more efficient than its first. In human teams, this kind of accumulation happens naturally. In Agent-driven teams, it needs to be explicitly engineered.
