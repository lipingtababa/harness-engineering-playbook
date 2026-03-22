# Two Agents at Once: Conflicts and Isolation

You launched two Agents on the same project. One is responsible for the payments module, the other for the billing module. Both Agents start working and modifying code. A few minutes later you discover: Agent A modified a shared utility function to accommodate payment logic, while Agent B simultaneously modified the same function to accommodate billing logic. The two modifications overwrite each other. Or a more insidious case: Agent A modified the database schema while Agent B is still writing queries based on the old schema. Each Agent's output passes tests in isolation, but they are based on different snapshots of the same codebase.

This is the most basic problem in distributed parallel development: concurrent modification of shared state. Human teams manage this with branching strategies and code ownership. Multi-Agent scenarios require the same mechanisms, but more explicit.

Each Agent needs an independent workspace. The most basic form is an independent git branch: each Agent works on its own branch and integrates through merge when done. Stricter isolation works at the directory or module level: Agent A can only modify files under `payments/`, Agent B can only modify files under `billing/`.

The Skill cards introduced in Chapter 4 take on a new role here. From a single Agent's personal memo, they become the multi-Agent team's job descriptions. The `trust_boundaries` field in Skill cards explicitly defines what each Agent can and cannot touch. "Do not change database schema" and "do not modify external API contracts" shift from suggestions to hard boundaries. When multiple Agents work in parallel, the clarity of responsibility boundaries directly determines the probability of conflicts.

The granularity of isolation should be determined by the project's architecture. Microservice architectures are naturally suited to Agent-level isolation: each Agent is responsible for one service. Monolithic architectures require more careful module partitioning. The principle is: the work scopes of Agents should be as orthogonal as possible; the smaller the intersection, the fewer the conflicts.
