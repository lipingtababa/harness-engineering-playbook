# From Wish List to Executable Constraints: Test First

You have clear acceptance criteria. The next step is to make them executable.

In traditional development, the primary motivation for test-driven development (TDD) is to drive design: write the tests first and let the test requirements shape the code's interfaces and structure. In the Agent era, the motivation for TDD undergoes a fundamental shift. Coding cost approaches zero. An Agent can generate a complete module implementation in minutes. When coding becomes nearly free, the relative value of testing trends toward infinity. Testing becomes your only objective measure of Agent output.

The concrete practice of test-first is: before the first line of business code lands, build the test framework based on the acceptance criteria in the spec. Each acceptance criterion maps to one or more test cases. Dependencies that do not yet exist are replaced with mocks, building an independent test environment decoupled from the overall service.

The effect is: when the Agent begins coding, it faces a set of existing, red tests. Its job is to make these tests green. The tests define what "done" means, and every modification the Agent makes gets immediate feedback.

Tests are the executable form of the spec. "A record appears on the billing page after successful payment," as written in the spec, becomes a concrete assertion in the test: call the payment interface with specific parameters, verify that a corresponding record was added to the database, and verify that the interface returned the expected status code. Vague natural language is transformed into precise, repeatably executable checks.

This means there is a strict mapping relationship between specs and tests. If an acceptance criterion cannot be translated into a test, that criterion itself needs to go back to the spec stage for further clarification. If a test contains assertions without corresponding acceptance criteria, those assertions are either superfluous or they expose an omission in the spec. The two must stay in sync.
