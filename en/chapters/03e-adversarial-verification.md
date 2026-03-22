# Output Too Fast to Review: Using Agents to Verify Agents

Test-first, Trophy testing, and continuous feedback work well within a single Agent's workflow. But as output speed ramps up, a new bottleneck appears: you cannot keep up with the reviews.

A single Agent's daily code output might equal a programmer's weekly output. Even with automated tests, humans still need to review whether the tests themselves are reasonable, whether the spec was correctly understood, and whether the implementation approach aligns with architectural intent. When these review tasks pile up beyond human processing capacity, either review quality drops or review becomes the bottleneck of the entire workflow.

Adversarial verification provides a solution. The core idea is borrowed from NASA's Independent Verification and Validation (IV&V) program: verification must be performed by a party independent of the developer. In Agent-driven development, this means using an independent Agent to verify another Agent's output.

The concrete approach: after the coding Agent completes its implementation, the output code and the original spec are both handed to an independent verification Agent. The verification Agent's task is to check the implementation against the spec criterion by criterion, annotating any deviations, omissions, or questionable decisions. The verification Agent only has the spec and the code; it cannot see the coding Agent's reasoning process, so its judgment is based entirely on the match between spec and implementation.

Cross-model verification further reduces the risk of shared blind spots. If the coding Agent uses Claude, the verification Agent can use GPT, and vice versa. Different model families have different training data and reasoning preferences; using different models for cross-validation can catch issues that a single model might overlook.

The output of adversarial verification is a gap report: which acceptance criteria were met, which have deviations, and which are completely missing. The human review target shifts from the code itself to this gap report. This dramatically reduces the human review burden: instead of reading code line by line, you focus on the discrepancy points annotated by the verification Agent.

Automated verification is a prerequisite for subsequent scaling. When you start running multiple Agents in parallel development (the topic of Chapter 5), having humans individually review each Agent's output becomes physically impossible. The adversarial verification system at that stage will shift from "useful aid" to "essential infrastructure."
