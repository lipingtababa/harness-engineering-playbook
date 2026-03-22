# What Kind of Tests Are Hardest to Game: The Trophy Testing Model

Anchoring tests to human acceptance criteria solves the collusion problem at the principle level. But in practice there is another question: what type of tests are hardest for Agents to circumvent?

Unit tests verify code's internal behavior: whether a specific function returns the expected output given a specific input. An Agent can easily pass unit test assertions by adjusting implementation details, and such adjustments may introduce problems at a higher level. A payment module that passes all unit tests might fail when integrating with the billing module, because unit tests only verified isolated behavior and did not cover inter-module interactions.

End-to-end integration tests verify at an entirely different granularity. They cover a complete capability path perceivable by the user: the user initiates a payment request, the system calls the payment gateway, writes the billing record, and returns a confirmation message. Any failure in a critical sub-path causes the entire test to fail. Faking a complete user journey is far more difficult for an Agent than faking an isolated function output.

This is the core idea behind the Trophy testing model. Contrary to the traditional testing pyramid (many unit tests, fewer integration tests, very few end-to-end tests), the Trophy model places its center of gravity at the integration test level. In Agent-driven development, the value of integration tests far exceeds that of unit tests because they are closer to the user's real usage scenarios and much harder to "superficially pass."

The principle for writing Trophy tests is to orient them around user-perceivable capabilities. Each Trophy test describes a complete user scenario from triggering action to final result. Its assertions are based on the system's externally observable behavior rather than internal implementation state. This means the Agent can only pass the test by genuinely implementing the functionality, rather than by tweaking internal implementation to bypass assertions.

This does not mean unit tests have no value. Unit tests still provide fast feedback loops during development, helping the Agent locate specific implementation issues. But as the basis for acceptance decisions, Trophy-level integration tests are the more reliable signal. Agents can be allowed to freely write and modify unit tests to aid development, but additions, deletions, and modifications to Trophy tests must be confirmed by humans.
