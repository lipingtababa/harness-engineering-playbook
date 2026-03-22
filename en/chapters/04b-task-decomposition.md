# Cutting Big Tasks into Agent-Sized Chunks: Task Decomposition

The goal of task decomposition is to ensure each task chunk completes before context collapse occurs. This requires splitting along two dimensions.

In the spatial dimension, modularization and API Contracts define the work fence for each Agent. Each module has complete input/output definitions; the Agent operates freely within the fence, and dependencies outside the fence are isolated through mocks. This gives each Agent a complete, self-contained work environment within its limited context window. It does not need to understand the entire system; it only needs to understand the module it is responsible for and its interface contracts with the outside.

API Contracts play a critical role here. They serve as both the technical boundary between modules and the cognitive boundary of the Agent's work scope. A clearly defined API Contract tells the Agent: you are responsible for implementing the logic behind this interface; what format the input takes, what format the output takes, and how error cases are handled are all written in the contract. The system beyond the contract is transparent to you; you do not need to and should not concern yourself with it.

In the temporal dimension, even within the same module, tasks are broken into small chunks. Each chunk is accepted upon completion, its output confirmed to meet expectations, and then context is reorganized for the next chunk. This directly counters the problem of early decisions being forgotten in long reasoning chains: through frequent context resets, each step executes in a clean, focused context.

The standard for judging granularity comes from practical experience. The ideal size for a task chunk is: the Agent can complete it within a single session, the output can be independently verified, and the completed code is in an integrable state. If a task chunk shows signs of the Agent contradicting itself during execution, the granularity is too large and needs further decomposition.

Combining both dimensions yields a hybrid execution mode. The requirements phase uses iterative exploration, allowing ambiguity and trial-and-error. Once the execution phase begins, it proceeds strictly in sequence: spec, test, code, acceptance. The spec is the dividing line. Before the spec: free iteration. After the spec: strict execution. This pattern can be summarized as "agile requirements, waterfall execution." AI Agents perform best under tight constraints. Loose processes lead to context contamination and drift.
