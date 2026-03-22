# Not Check After Done, but Check While Doing: Continuous Feedback During Execution

With test-first and Trophy testing, you have established the anchor and gate for verification. But there is still a time dimension question: when to verify?

If you wait until the Agent finishes writing all the code before running tests, you may face dozens of failing test cases, each pointing to a different problem. The cost of tracing and fixing these problems is high, because errors may have occurred early in the Agent's agentic loop, and all subsequent code was built on a flawed foundation.

A more effective approach is continuous verification during execution. Every time the Agent completes a small step, it immediately runs the relevant tests. If a test fails, it fixes the issue immediately, correcting the deviation before it propagates. This is the red-green-refactor inner loop: write a test (red), write code to make it pass (green), refactor the code to maintain quality (refactor), then move on to the next test.

The value of continuous feedback lies in shortening the survival time of deviations. As we analyzed in Chapter 1, Agents gradually drift from early decisions during long reasoning chains. If a deviation occurs at iteration 5 but is not discovered until iteration 50, all the output from the 45 intervening iterations may need to be discarded. If the deviation is caught and corrected by a test at iteration 5, the blast radius is minimized.

Phase gates are continuous feedback at a coarser granularity. Before entering the coding phase, machine-readable acceptance criteria and at least the skeleton of a Trophy test must exist. Before entering the integration phase, all module-level tests must pass. Before entering the merge phase, all Trophy tests must pass. Each phase gate defines clear preconditions; the Agent can only proceed to the next phase after satisfying the conditions.

If tests at any phase reveal ambiguity or gaps in the spec, the process rolls back to the specification phase. Pause coding, update the spec, confirm through review, then continue. This rollback mechanism ensures problems are fixed at their source rather than worked around downstream.
