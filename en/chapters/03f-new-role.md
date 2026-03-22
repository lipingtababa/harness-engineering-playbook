# So What Do I Do: From Reviewing Code to Designing Verification Systems

At this point, a fundamental role shift has already occurred.

In traditional development, one of the core tasks of a senior engineer is code review: reading team members' code line by line, checking logical correctness, code style, potential performance issues, and security vulnerabilities. This work relies on the reviewer's deep understanding of the system and rich engineering experience.

In Agent-driven development, line-by-line code review becomes both infeasible (the speed cannot keep up) and suboptimal (human attention should be spent on higher-leverage activities). The verification system takes over most of the responsibilities of traditional code review. Tests verify functional correctness. Adversarial Agents check spec conformance. Automated tools check code style and security vulnerabilities.

The human role shifts from reviewing code to two higher-leverage activities.

First, reviewing tests and specs. Do the acceptance criteria accurately reflect business intent? Do the Trophy tests cover critical user scenarios? Do the test assertions verify behavior rather than implementation details? These judgments require understanding the business and grasping user needs, something Agents cannot replace.

Second, designing the verification system itself. At which points should gates be set? What types of tests should cover what levels of risk? How should adversarial verification rules be configured? The design of the verification system determines the upper bound of reliability for the entire development workflow.

Merge criteria also change accordingly. The traditional merge standard is "pass code review + CI tests all green." In Agent-driven development, passing correctness tests is still a necessary condition but not sufficient. Before merging, at least one fitness signal is also needed: end-to-end Trophy tests pass, or real data replay verification passes, or stakeholder acceptance is confirmed. If none of these are available, the exemption rationale needs to be explicitly documented.

This role shift has profound implications for the team's capability structure. Traditional teams most value coding ability: algorithm skills, language proficiency, debugging techniques. Agent-driven teams most value specification ability and verification design ability: whether business intent can be translated into testable acceptance criteria, and whether effective verification strategies can be designed to ensure output quality. Coding ability gives way to engineering judgment.
