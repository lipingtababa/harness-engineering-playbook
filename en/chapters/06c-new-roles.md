# Redesigning Roles Around Governance, Not Execution

Traditional team roles are designed around the execution layer: who writes frontend code, who writes backend code, who writes tests, who handles operations. When Agents take over the execution layer, role definitions need to move up from the execution layer to the governance layer: who defines what to do, who orchestrates how to do it, who verifies that it was done correctly.

There are currently two main directions of exploration in the industry.

**The Alpha Wolf Model.** 黄东旭's practice at PingCAP represents this direction: a top-tier engineer takes end-to-end ownership of a product or module. This person simultaneously plays the roles of product manager, architect, lead programmer, and test lead, commanding a pack of Agents within their own territory. They spend 90% of their time evaluating AI work output rather than writing code.

The advantage of the alpha wolf model is an extremely short decision chain. One person has the complete context, needs no cross-role communication, needs no approval waiting, and can iterate at very high speed. 黄东旭 used this model to rewrite TiDB's PostgreSQL compatibility layer to near-production level.

The bottleneck of the alpha wolf model is talent. This role requires a combination of product sense, architectural capability, coding experience, and quality awareness. People who meet these criteria are exceptionally rare, and such individuals often prefer starting their own ventures to working for others. Most companies' teams cannot find or retain such people.

**The Product Tri-Ownership Model.** Another direction proposed by the community is to decompose the super-individual's capabilities into three trainable specialist roles. This approach draws inspiration from the construction industry: the architect defines the space, the structural engineer designs the structure, an independent inspector accepts the work, and the construction firm executes. In the Agent era, the construction firm is the Agent.

The Product Owner is responsible for what to do: defining the product vision, managing user stories and acceptance criteria, and deciding priorities. They are accountable for the value of the output, not for the output itself.

The Tech Owner is responsible for how to do it: detailed design, Agent workflow orchestration, and tool selection. Their core responsibility is designing and optimizing the collaboration patterns of multiple Agents. Different task types require different workflows; a bug fix workflow differs from a new feature workflow, and the Tech Owner is responsible for designing the appropriate workflow for each.

The Quality Owner is responsible for whether it was done correctly: designing quality processes, full-lifecycle quality control, and independent verification. The Quality Owner's existence directly solves the collusion problem: the Agent producing the code and the Agent verifying the code are managed by different people with misaligned interests, creating a natural adversarial relationship.

The PTO model's advantage is replicability. Each of the three roles is easier to develop than a super-individual. The disadvantage is that it requires organizational change, tight collaboration chemistry among three people, and boundary calibration between roles.

Beyond these two models, there is a gentler training-based approach: keep the organizational structure unchanged, have one experienced person customize skills, agents, and workflows, and let team members execute according to the process. The barrier to entry is lowest, but the value ceiling is also lowest.
