# Multiple Sources Contradict Each Other: Trust Rings and Adjudication Rules

You have started systematically externalizing tacit knowledge, writing architectural decisions, known constraints, and historical lessons into your documentation system. But a new problem surfaces: as information sources multiply, they start contradicting each other.

The architecture document says this service should use a REST API, but the notes from a recent design discussion mention that the team has decided to migrate to gRPC. A code comment marks a deprecated data format, but the spec still references that format. The product requirements document says "support batch operations," and the technical design document says "first phase only supports single-item operations."

When an Agent encounters these contradictions, it handles them very differently from a human. A human engineer would pause and ask a colleague, or use their overall understanding of the project to judge which information source is more trustworthy. An Agent picks one from the contradictory sources and continues executing. Its selection criteria might be whichever information appears later in the context, whichever is worded more specifically, or other unpredictable factors. The result: each execution may produce a different choice, adding a hidden source of randomness to the output.

Trust rings are the mechanism for solving this problem. The core idea is to layer information sources by priority; when information conflicts, higher-priority sources override lower-priority ones.

Ring 0 is the spec itself. It is the single source of truth; when all other information sources conflict, the spec prevails. Whatever the spec says, the Agent executes.

Ring 1 is architecture documents and API contracts. They define the structural constraints of the system. If the spec does not address a particular technical decision, the architecture document takes precedence.

Ring 2 is design discussion records, technical proposals, and meeting notes. They provide background and context for decisions but may contain outdated or rejected proposals.

Ring 3 is everything else: code comments, personal notes, external references. Their reliability is lowest, and they serve only as supplementary information.

The trust ring rules need to be explicitly stated in the Agent's working instructions. For example: "When multiple information sources describe the same decision differently, adjudicate by the following priority: spec > architecture document > design discussion > other sources. If you find information conflicts, annotate the conflict points and the source you adopted in your output."

That last rule is particularly important: requiring the Agent to annotate conflict points. This transforms implicit random decisions into explicit, auditable choices. During human review, you do not need to read code line by line; you only need to check the conflict points annotated by the Agent and its adjudication rationale.

Trust rings also need maintenance. When a decision from a design discussion is finalized, it should be promoted to part of the architecture document or spec. When an old document is superseded by a new decision, the old document should be marked as deprecated or deleted. The hierarchy of information sources changes as the project evolves; maintaining trust rings is part of maintaining the specification system.
