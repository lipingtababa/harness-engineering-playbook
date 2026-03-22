# More Context Is Not Always Better: Context Engineering

Task decomposition solves the question of "how big should a task chunk be." But what goes into the Agent's context window when each task chunk executes is equally critical.

The intuitive approach is to stuff in everything that might be relevant: the complete architecture document, all related modules' code, historical design discussion records, the project README. More information is better, right?

Practice shows precisely the opposite. Community experiments have observed that verbose or noisy context reduces success rates and increases reasoning costs, even when nowhere near the token limit. More context causes information to compete for attention, diluting critical information with noise.

Context contamination has six typical types.

Stale contamination. Outdated documents, comments, and architecture diagrams enter the context, and the Agent makes decisions based on outdated information. The code has been refactored three times, but the architecture document is still on version one.

Conflict contamination. Multiple information sources with unclear priority cause the Agent to make random choices when facing contradictory information. The trust ring mechanism from Chapter 2 can mitigate this, but only if conflicts are identified and annotated.

Reasoning contamination. When the Agent is asked to reason across multiple documents, it may introduce errors in the derivation process. Document A says "user IDs are UUIDs," Document B says "the orders table has a foreign key user_id," and the Agent derives "the orders table's user_id field is UUID type." But the orders table is actually a legacy system where user_id is an auto-incrementing integer.

Compression contamination. When context becomes too long, some tools or frameworks automatically compress historical content. Critical signals may be lost during compression, and the retained information may not be the most important.

Collusion contamination. AI-generated tests verifying AI-generated code; Chapter 3 already discussed this problem.

Legacy contamination. Deprecated code patterns, dead code, and abandoned APIs enter the context, and the Agent treats them as valid references and replicates these patterns.

The core principle for addressing context contamination is: layer during design, flatten during execution. During the design and organization phase, information is managed in a hierarchical structure (trust rings, document classification, priority annotations). But when the Agent actually executes, the layered documents are flattened into a single, self-contained input document. Avoid having the Agent reason across layers during execution, as cross-layer reasoning is the primary source of reasoning contamination.

Priority-based information filtering determines what enters the context window. P0 information (spec, current task's acceptance criteria, directly relevant API contracts) must be in the context. P1 information (related module interface definitions, architectural constraints) is selectively included based on available space. P2 and below (background discussions, historical decisions, reference materials) are excluded by default, provided on demand only when the Agent explicitly needs them.

The context window is a scarce resource. Managing it follows the same principles as managing server memory: you cannot fit everything, so you need to decide what stays in, what goes out, and what gets cached externally.
