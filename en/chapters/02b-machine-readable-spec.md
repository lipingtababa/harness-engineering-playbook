# An Operations Manual for Machines: What Machine-Readable Specs Look Like

A traditional requirements document is a communication tool. Its reader is a human, and its purpose is to build consensus between the product manager and the programmer. Therefore it can use natural language narrative, omit "obvious" details, and use references like "refer to the existing implementation." Human readers fill in these omissions and references with their own knowledge and experience.

A spec written for an Agent is an operations manual. Its reader is a practitioner with zero prior knowledge. It must be self-contained: all relevant constraints, boundary conditions, and definitions of done must be explicitly stated. It must be verifiable: every acceptance criterion should be translatable into a test case. If you cannot write a test for an acceptance criterion, that criterion itself is too vague and needs to go back to the requirements stage for clarification.

A minimal machine-readable spec should contain the following structure:

```
task_id: FEAT-123
context: ["/docs/arch.md#payments", "/tickets/9876"]
inputs:
  - name: amount
    type: decimal
invariants:
  - amount > 0
acceptance_criteria:
  - "After successful payment, a record with amount=amount and status=success appears on the billing page"
  - "On failure, return a localizable error code; no record is written to billing"
non_goals:
  - "Do not handle installments or refunds"
```

Each field serves a clear engineering purpose.

`task_id` links the spec to the project management system, making changes traceable. `context` points to the relevant documents and code the Agent needs to read, bounding its information scope. `inputs` and `invariants` define the input space and constraints, telling the Agent which inputs are valid and which boundaries need to be defended. `acceptance_criteria` is the most critical part: it defines what "done" means. Each criterion should be specific enough to directly generate test assertions. `non_goals` explicitly delineates the boundaries of scope, preventing the Agent from overreaching.

This structure can be extended based on project needs. Some teams add `dependencies` (other modules this depends on), `risk_level` (risk level, influencing subsequent review processes), `examples` (concrete input/output examples), and other fields. But the core principles remain consistent: self-contained, verifiable, and clearly bounded.

The writing of acceptance criteria deserves special emphasis. Compare these two versions:

Vague version: "The system should correctly handle payment failures."

Clear version: "When the payment gateway returns a 4xx error code, the system returns the corresponding localized error message, does not create a billing record, and does not deduct the user's balance. When the payment gateway times out (>30s), the system marks the transaction as pending, initiates an asynchronous query, and if not confirmed within 5 minutes, automatically cancels and notifies the user."

The vague version gives the Agent an enormous decision space: what counts as a "payment failure"? What counts as "correctly handling" it? The Agent will make some choice, but whether that choice aligns with your intent comes down to luck. The clear version compresses the decision space to near zero: the expected behavior for every case is explicitly defined and can be directly translated into test cases.

Write acceptance criteria as if they were evaluation functions. If after reading a criterion, you and another engineer might give different answers about whether it is satisfied, that criterion needs further decomposition and clarification.
