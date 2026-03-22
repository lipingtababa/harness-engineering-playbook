# Input Determines Output: Why the Bottleneck in the Agent Era Is Specification

Chapter 1 analyzed the faithful execution characteristic of Agents: an Agent's behavioral pattern is faithfulness to its input, and the quality of the input determines the ceiling of the output. This characteristic has very concrete engineering implications at the specification level.

In traditional development, requirements documents can be vague. A product manager writes "users should be able to conveniently view their billing history," and the programmer automatically fills in a large number of details based on their understanding of the product, their knowledge of users, and their familiarity with the tech stack: pagination or infinite scroll? Reverse chronological or chronological order? How to handle loading failures? The majority of these decisions are reasonable, and the occasional deviation from intent gets caught and corrected during code review.

When an Agent faces the same vague requirement, its behavior is entirely different. It similarly makes all these decisions, but each decision is based solely on the information provided in the input. If the input says nothing about pagination strategy, the Agent picks one. The basis for its choice might be the statistical distribution in training data, a hint from an unrelated piece of code in the context, or randomness. You cannot know until you review the output.

This means the bottleneck has shifted. In traditional development, the bottleneck is execution speed: how fast the programmer writes code determines the delivery cadence. In the Agent era, the bottleneck is specification clarity: however many ambiguities exist in the spec, that many uncertainties exist in the output. An Agent can write a module's code in minutes, but if the spec has ten ambiguities, you may get ten different versions of the implementation, each one "correctly" satisfying the vague requirements, but only one being what you actually want.

The most effective lever for improving Agent output quality is on the input side, in the specification.
