# Structural Characteristics of AI

Based on the technical foundation above, we can identify five structural characteristics of AI Agents as software development practitioners. Each characteristic creates specific engineering challenges that are either naturally absorbed or simply do not arise in a human practitioner environment.

## Faithful Execution

An Agent's behavioral pattern is faithfulness to its input. Given clear and complete specifications, it can deliver high-quality implementations. Given vague or flawed specifications, it just as faithfully compiles the vagueness and flaws into code. An Agent's behavior is closer to a compiler: the quality of the input determines the ceiling of the output.

**Ambiguities become random decisions.** When a human programmer encounters a vague requirement, they draw on personal experience and business common sense to fill in the gaps, or proactively seek clarification from the product manager. Facing the same ambiguity, an Agent simply makes a choice and continues executing. That choice may be correct or may deviate from intent, and you cannot know until you review the output. In a human practitioner environment, moderate ambiguity in requirements is acceptable because the practitioner can fill in the blanks with common sense. When the practitioner is faithful to the input, every ambiguity in the spec becomes a source of uncertainty in the output.

**Knowledge not provided equals knowledge that does not exist.** Teams carry large amounts of undocumented tacit knowledge: why a certain module uses a particular design pattern, why a certain API's error handling employs a special strategy, what known data format anomalies exist for a specific customer. Human programmers gradually absorb this knowledge through daily collaboration. Agents can only rely on information explicitly provided. If a business rule is not included in the input context, it has never existed in the Agent's world. The resulting code will functionally and correctly ignore that rule.

## Limited Processing Capacity

The amount of information an Agent can effectively process in a single interaction has a hard upper limit. When a task involves too many files, too long a dependency chain, or overly complex business logic, output quality degrades catastrophically beyond a certain threshold.

**Task scale negatively correlates with output quality.** This has similarities to the cognitive load problem in humans, but with a key difference. Human programmers possess a persistent mental model of the entire system and can maintain global consistency while working locally. An Agent reconstructs its understanding within a finite window in every interaction. When a task requires simultaneously considering the database schema, API contracts, frontend state management, and the permissions model, a human can rely on long-accumulated system understanding to maintain consistency. An Agent must fit all relevant information within its current window; anything that does not fit gets ignored.

**Early decisions are forgotten in long reasoning chains.** Within the same session, if the agentic loop goes through many iterations, early design decisions gradually get pushed out of the effective processing window as new context is added. Interface specifications defined in the first half get silently altered in the second half's implementation. An error handling strategy chosen in the first half gets replaced by a different approach in the second half. This process is silent; the Agent itself is unaware that it is contradicting itself.

## No Memory Accumulation

Agents lose all context at session boundaries. The project understanding accumulated during the previous session, the pitfalls encountered, and the design decisions made all reset to zero in a new session.

**Organizational knowledge cannot naturally accumulate and evolve.** The longer a human team works on a project, the richer the tacit knowledge they accumulate: the historical reasons behind architectural decisions, the fragile points of each module, the conventions for handling specific business scenarios. Most of this knowledge has never been documented and transfers naturally through daily collaboration. Agent-driven teams lack this natural accumulation process. The hundredth session performs at the same level as the first. Good design decisions and bad design decisions appear with equal probability.

The deeper problem is this: even when knowledge is externalized into documentation, the documentation itself requires ongoing maintenance. Knowledge in human minds updates automatically as the project evolves; knowledge in documents rots if not explicitly maintained, gradually becoming a misleading information source. Externalizing knowledge is only half the problem; the mechanism for evolving that knowledge is the complete solution.

## High Throughput at Zero Marginal Cost

An Agent's code output speed is 10 to 100 times that of a human, and multiple Agent instances can be spawned simultaneously to handle independent tasks in parallel. The marginal cost of adding one more Agent instance approaches zero.

This characteristic plays a special role among the five: it both creates its own challenges and amplifies the impact of the other four. Faithful execution is a manageable problem at human speed; at 100x speed, it becomes a systemic risk. A vague spec under human execution might produce two or three deviations needing correction; under Agent execution, it might produce dozens of divergent implementations within an hour. No memory is a minor inconvenience at two or three sessions per day; at dozens of sessions per day, it is a serious knowledge fracture.

**Output speed exceeds human quality assurance bandwidth.** In traditional software engineering, human execution speed provides a natural time buffer for all downstream activities. The pace of code review, architectural assessment, and integration test design matches human output speed. When output speed increases by two orders of magnitude, this matching breaks down. Review degrades from line-by-line reading to spot checking; deviations get solidified by dozens of subsequent commits before humans discover them. The slow speed of human output was itself an error containment mechanism. High throughput removes this natural barrier.

## No Consequence Awareness

Agents have no awareness of the long-term consequences of their output. They optimize for satisfying the current instruction and have no intrinsic motivation for the long-term maintainability of the code.

**Lack of intrinsic quality drive.** Human programmers have an intrinsic motivation to care about code quality. Code readability, architectural elegance, and tech debt control stem partly from professional pride and partly from the expectation of "having to maintain this code three months from now." Agents lack this intrinsic drive. They faithfully replicate patterns already present in the codebase, including bad patterns. Merged code becomes the reference set for subsequent generation, creating a self-reinforcing quality degradation loop. The rate of tech debt accumulation correlates directly with output speed. Tech debt that a human team would accumulate over a year, an Agent-driven team can reach in a matter of weeks. There is no internal force in the system pushing toward refactoring. By the time humans realize refactoring is needed, the system scale may already make the refactoring cost prohibitively high.

**No risk-level differentiation.** Agents handle all tasks at the same speed and with the same level of attention. Modifying a piece of display copy and modifying payment deduction logic are treated identically at the execution level. Human programmers instinctively slow down, increase confirmation steps, and seek second opinions when facing high-risk operations. Agents lack this intrinsic risk deceleration mechanism. Under high-throughput conditions, large numbers of tasks are executed at the same speed, with high-risk operations mixed in, and no internal signal suggesting extra caution is needed.
