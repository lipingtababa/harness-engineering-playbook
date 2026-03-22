# Spec Is Clear but Output Still Misses Things: Externalizing Tacit Knowledge

Your spec is structurally complete, acceptance criteria are explicit, and doc testing has passed. But the Agent's output still has unexpected problems: it used a library the team deprecated long ago, touched an API endpoint with a known bug, or used the simplest but slowest implementation on a performance-critical path.

The root cause of these problems is not in the spec's clarity but in its completeness. Teams carry large amounts of undocumented tacit knowledge that has never been written into any document, yet every experienced team member knows it.

Typical types of tacit knowledge include:

Historical reasons behind architectural decisions. "Why does this module use event-driven instead of RPC? Because two years ago we hit a cascading failure and decided to decouple." The reason for this decision is not written in the code or the architecture documents; it exists in the memory of the engineers who were involved in that incident. When the Agent sees two communication patterns mixed in the code, it might "unify" them into one, and happen to choose the one we already decided to deprecate.

Module fragility points. "This service hits database connection pool exhaustion when concurrency exceeds 200; callers need to implement rate limiting." This constraint has never been formalized as part of the API contract, but every team member who has written integration code knows it. The Agent's integration code performs flawlessly in functional tests but only reveals the problem under stress testing.

Special handling for specific customers. "Customer X's data format has a known anomaly: the date field can be an empty string instead of null. Our parser has a compatibility layer specifically for this." This information exists in a postmortem document from a past incident but has never been linked to the data parsing module's spec.

Systematically externalizing tacit knowledge requires a proactive information gathering process. One effective approach is to incorporate structured questions during the spec writing phase: what are the known pitfalls of this module? What constraints are not written in the code or documentation? If a new hire were doing this task, what would you specifically warn them about? The answers to these questions need to be captured and written into the spec's context or invariants fields.

Externalizing tacit knowledge is an ongoing process. Every time an Agent's output reveals a piece of undocumented tacit knowledge, that knowledge should be captured and deposited into the specification system. Over time, the spec becomes increasingly complete, and the probability of the Agent hitting unknown landmines decreases. This is the concrete manifestation of the evolution principle at the specification level.
