# When a Task Doesn't Finish: Task-Level Handoff Documents

Skill Cards addressed the problem of an Agent not knowing who it is or what it can do when a new session starts, providing role definitions and behavioral boundaries. But tasks do not always complete within a single session; when execution is interrupted and a new session must pick up the work, another problem emerges: the new session's Agent has no knowledge of how far the task has progressed.

A task failing to complete within a single session might sound like an edge case — it is not. Section 04b's task decomposition assumes each subtask can be completed within a single session, but the failure rate of that assumption is far higher than intuition suggests.

Unpredictable context consumption is the first reason. A self-contained task specification defines the scope of information an Agent needs to read — but during execution, the Agent actively reads external documents not explicitly required by the spec: checking an implementation to understand an interface, reading upstream module code to confirm a data format. These are reasonable engineering behaviors, but each read consumes context window. External documents are frequently longer than estimated; a task that should complete at 60% of window capacity may still be unfinished at 90%.

Model output nondeterminism is the second reason. Large language models generate outputs probabilistically — ten executions of the same input do not produce the same result. Most of the time an Agent completes the task smoothly; occasionally it takes detours — attempting unnecessary approaches, re-solving already-solved problems, over-exploring a branch. This nondeterminism is a fundamental property of the model; it cannot be eliminated through better specifications, only absorbed through fault-tolerance mechanisms.

Supply-side instability is the third reason. API provider service quality is not constant: models may be silently downgraded during peak hours, the actual available context window may be smaller than documented, and rate limits may trigger mid-task. These factors are entirely outside the control of task decomposition design.

These factors combine toward a single outcome: a task will likely be unable to complete within a single session without triggering compression. Once context approaches saturation, most tooling will trigger automatic compression — summarizing or truncating history to free up space. Compression is irreversible information loss: early design decisions, interface conventions, and details of completed work are discarded unpredictably. The context wall described in 04a is a gradual quality degradation; compression is a one-time cliff. After compression, the Agent's behavioral determinism cannot be guaranteed — at that point, the right move is to terminate the current session and start a new one to continue.

When a task can't finish in a single session, a new session must pick up from some intermediate state — not restart from scratch. Restarting faces the same constraints: context consumption, model nondeterminism, and supply-side instability are still present, and a new session will likely hit the same wall at the same point. Only by continuing from where the previous session stopped can the task advance incrementally across sessions and eventually reach completion. The new session has no prior context; the only thing it can rely on is what was written down. This is the rationale for task-level handoff documents.

The goal of a handoff document is to enable an Agent with zero prior context to pick up the task. But "picking up" does not mean inheriting the previous session's reasoning — the value of a new session lies precisely in being an independent judge, capable of spotting where the previous session went astray.

This leads to the core design principle of handoff documents: record only facts, not inferences.

Facts are things that have already happened: which code has been written, what choices were made, what blockers were encountered. This information can be verified against actual code and test results. Inferences are judgments about the future: what to do next, what approach to recommend. This information cannot be verified; it can only be trusted or questioned.

If the previous session's execution path had a bias, inference-type information encodes that bias into the handoff document. A new session that sees a "next steps plan" will likely follow that path directly, losing the opportunity for independent course correction. This is the collusion problem (03b) manifesting between sessions: the previous session both executes the task and plans what comes next, setting its own direction. Inference-type information in a handoff document is also a form of reasoning contamination (04c): the reasoning artifacts of one session enter the next session's context and interfere with independent judgment.

Therefore, handoff documents have no `next_steps` field. After receiving the factual information, the new session derives its next steps independently by consulting the original specification (the Ring 0 trust source, 02e).

A minimal handoff document contains the following fields:

```
spec_ref: "/specs/auth-module.md"

status:
  completed:
    - "JWT issuance logic (RS256) — unit tests passing"
    - "Login endpoint /api/login — integration tests passing"
  in_progress:
    - "Token refresh endpoint /api/refresh — issuance complete, revocation logic not started"
  pending:
    - "Logout endpoint /api/logout"
    - "Token blacklist mechanism"

decisions:
  - what: "Chose RS256 over HS256"
    why: "Cross-service verification required; asymmetric signing allows services to hold only the public key"
  - what: "Stored refresh token in database instead of Redis"
    why: "Current user volume doesn't require Redis; reduces infrastructure complexity"

blockers:
  - "user table missing refresh_token_hash column — migration required first"
  - "Discovered conflict between existing session middleware and JWT logic — need to confirm whether to replace"

files_changed:
  - "src/auth/jwt.py — created"
  - "src/auth/login.py — created"
  - "tests/auth/test_jwt.py — created"
  - "tests/auth/test_login.py — created"
```

`spec_ref` points to the original specification; specification content is not duplicated in the handoff document. Duplication means two documents can become inconsistent — spec decay (02f) applies equally to handoff documents. The new session treats the specification as the authoritative information source; the handoff document provides only execution state. When the two conflict, the specification takes precedence.

`status` uses three states rather than a simple complete/incomplete. `in_progress` is the most critical state — it marks work that is half-done. A subtask that's either untouched or fully complete is easy to handle. Half-done is the most dangerous: if the new session doesn't know which parts are already implemented and which aren't, it may re-implement existing logic, or build on top of half-finished work and produce inconsistencies.

`decisions` records choices already made and the reasons for them. The `why` here is fundamentally different from the deliberately excluded `next_steps`: decisions describe existing code facts (the code already uses RS256), and `why` helps the new session judge whether a choice needs to be reversed — a retrospective explanation, not a forward-looking instruction. Unrecorded decision rationale is equivalent to nonexistent (02d); the new session may reverse a well-reasoned design choice without knowing it.

`blockers` records obstacles discovered during execution. A human engineer naturally remembers where they got stuck yesterday; an Agent does not. A blocker that isn't written down may be silently skipped by the new session, producing code that will inevitably fail at integration.

`files_changed` provides a factual inventory of changes, letting the new session verify actual code state rather than blindly trusting what the `status` field claims.

Handoff documents are only produced when a task cannot be completed within a single session — a product of the fault-tolerance mechanism, not a part of the normal flow. When a task completes successfully, no handoff document is needed; output flows directly into the subsequent verification process.

The problem is: who decides when to write? The Agent itself is not a reliable trigger. There are two reasons. First, agents currently lack general awareness of their own context consumption — they don't know how much window remains. Second, even if a model could perceive this, large language models generate probabilistically; judgment under the same conditions is not stable. Writing a handoff document is a deterministic task — it must happen at the right moment, and cannot depend on probabilistic guarantees. Therefore, triggering must come from external deterministic tooling, not from the model itself.

One approach is through the tooling framework's hook mechanism: configure a threshold so that when token usage exceeds it, an instruction is injected into the Agent telling it to stop current work and save progress in the handoff document structure. Another approach is an independent monitoring process that continuously tracks token usage and injects a prompt when the limit approaches. The former is coupled to a specific tooling framework; the latter requires additional infrastructure but has broader applicability. What both approaches share is that the sensing and triggering logic is handled by an external deterministic system, decoupled from the model's probabilistic characteristics.

Regardless of which approach is used, triggering must happen before automatic compression begins. Once compression starts, the Agent's memory of completed work is already incomplete; a handoff document written at that point cannot reflect true state. The trigger threshold needs to leave enough window space for the Agent to complete the write while context is still intact.

After the handoff document is written, the current session terminates. The new session loads the original specification and the handoff document, plans independently based on facts, and continues executing the unfinished portions. Once the task is finally complete, the handoff document is archived for later retrospection.
