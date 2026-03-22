# Table of Contents

* [Introduction: High-Quality Delivery at 100x Productivity](README.md)
* [Structural Characteristics of AI and Engineering Challenges](chapters/01-framework.md)
  * [How Agents Work](chapters/01a-how-agents-work.md)
  * [Structural Characteristics of AI](chapters/01b-characteristics.md)
  * [Why Your AI Transformation Is Stuck](chapters/01c-why-transformation-fails.md)

### Part I: Reliable Agent Programming (1→10x)

* [The Starting Point of Reliable Delivery: Specification](chapters/02-specification.md)
  * [Input Determines Output: Why the Bottleneck in the Agent Era Is Specification](chapters/02a-why-spec.md)
  * [An Operations Manual for Machines: What Machine-Readable Specs Look Like](chapters/02b-machine-readable-spec.md)
  * [How to Verify After Writing: Finding Gaps Before Coding with Doc Testing](chapters/02c-doc-testing.md)
  * [Spec Is Clear but Output Still Misses Things: Externalizing Tacit Knowledge](chapters/02d-tacit-knowledge.md)
  * [Multiple Sources Contradict Each Other: Trust Rings and Adjudication Rules](chapters/02e-trust-rings.md)
  * [Specs Rot Too: Failure Modes and Continuous Maintenance](chapters/02f-spec-decay.md)
* [The Backbone of Reliable Delivery: Automated Quality Control](chapters/03-verification.md)
  * [From Wish List to Executable Constraints: Test First](chapters/03a-test-first.md)
  * [AI Writes Code and Tests: The Collusion Problem](chapters/03b-collusion.md)
  * [What Kind of Tests Are Hardest to Game: The Trophy Testing Model](chapters/03c-trophy-testing.md)
  * [Not Check After Done, but Check While Doing: Continuous Feedback During Execution](chapters/03d-continuous-feedback.md)
  * [Output Too Fast to Review: Using Agents to Verify Agents](chapters/03e-adversarial-verification.md)
  * [So What Do I Do: From Reviewing Code to Designing Verification Systems](chapters/03f-new-role.md)

### Part II: Scaling Agent Development (10→100x)

* [Letting Agents Run: Decomposition, Context, and Memory](chapters/04-long-running.md)
  * [What Happens After You Let Go: The Context Wall](chapters/04a-context-wall.md)
  * [Cutting Big Tasks into Agent-Sized Chunks: Task Decomposition](chapters/04b-task-decomposition.md)
  * [More Context Is Not Always Better: Context Engineering](chapters/04c-context-engineering.md)
  * [Session Over, Where Did the Knowledge Go: Cross-Session Memory Engineering](chapters/04d-memory.md)
  * [A Session Is Not a Chat Log: Engineering the Execution Unit](chapters/04e-session.md)
  * [From Hand-Holding to Letting Go: The Shift in Execution Mode](chapters/04f-letting-go.md)
* [Multi-Agent Parallelism: Isolation and Integration](chapters/05-multi-agent.md)
  * [Two Agents at Once: Conflicts and Isolation](chapters/05a-isolation.md)
  * [Each One Correct, Together They Explode: Contracts and Integration](chapters/05b-integration.md)
  * [Build the Runway Before Launching the Planes: Platform Engineering First](chapters/05c-platform.md)
    * [Millisecond Feedback: Static Analysis and Code Standards](chapters/05c1-linters.md)
    * [Seconds-to-Minutes Feedback: CI/CD as a Feedback Channel](chapters/05c2-cicd.md)
    * [Minutes-to-Days Feedback: Observability](chapters/05c3-observability.md)
    * [Measuring Business Quality: Benchmark-Driven Feedback Loops](chapters/05c4-benchmark.md)
    * [Environment as Code: Reproducibility as the Foundation of Reliable Feedback](chapters/05c5-iac.md)
    * [When the Signal Turns Red: Agent Troubleshooting Capability](chapters/05c6-troubleshooting.md)
  * [How Many Can You Manage: Span of Control](chapters/05d-span.md)

### Part III: Governing the 100x Organization

* [Multi-Person Collaboration: Organizational Design for Hybrid Teams](chapters/06-hybrid-team.md)
  * [Why Your Team Structure No Longer Works](chapters/06a-why-old-structure-fails.md)
  * [Bottleneck Shift: From Code to Organization](chapters/06b-bottleneck-shift.md)
  * [Redesigning Roles Around Governance, Not Execution](chapters/06c-new-roles.md)
  * [Making Processes Match Agent Speed](chapters/06d-process-speed.md)
  * [Define Boundaries Before Deploying Agents: Conway's Law Still Applies](chapters/06e-conway.md)
  * [No Silver Bullet, but There Are Principles](chapters/06f-principles.md)
* [Organizational Assets for the New Era](chapters/07-beyond.md)

---

* [Contributors](contributors.md)
