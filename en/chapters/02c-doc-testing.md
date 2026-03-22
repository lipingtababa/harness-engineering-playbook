# How to Verify After Writing: Finding Gaps Before Coding with Doc Testing

You have written a spec that you believe is clear and complete. How do you know it is actually good enough?

The intuitive approach is to hand it to an Agent for execution and see whether the output matches expectations. But this feedback loop is too long: the Agent writes the code, you review the code, discover deviations, trace them back to ambiguities in the spec, modify the spec, and re-execute. Fixing a single ambiguity might take an hour. If the spec has five ambiguities, there goes a full day.

Doc testing[^1] provides a shorter feedback loop. Its core idea is: before writing any code, use AI to conduct "thought experiments" on the spec itself.

The concrete approach is to use user stories as test cases and have AI walk through the spec step by step. For each user story, starting from the triggering action, check whether the spec provides a complete execution path: are the required interfaces defined? Are parameters and return values complete? Are exception cases covered? Are state transitions consistent?

For example, for a payment module spec, you could ask AI to walk through a user story like: "The user submits a payment request, the payment gateway returns a timeout, and the user submits the same payment request again while still waiting." If the spec does not define an idempotency handling strategy, doc testing will get stuck here, exposing this gap.

The cost of this process is only token consumption. A complete doc testing session typically finishes in minutes. In comparison, having the Agent write all the code before discovering spec problems costs an order of magnitude more to fix.

Doc testing has clear limitations. AI may hallucinate during the walkthrough: it may claim a path works when the spec does not actually provide sufficient information. Therefore, doc testing results need human review. Its value lies in dramatically reducing the cost of finding problems, not in completely replacing human judgment.

Every issue discovered through doc testing needs to be written back into the spec. If doc testing reveals a missing boundary condition, the fix is to add the corresponding entry to the spec's acceptance_criteria, not to mentally note "remember to watch for this next time." The spec is the single source of truth; all knowledge and decisions must be captured in the spec.

[^1]: The doc testing concept was proposed by 胥克谦 (AgentZones community).
