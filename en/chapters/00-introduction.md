# Introduction: From Vibe Coding to Harness Engineering

## When Vibe Coding Hits a Wall

You have probably had an afternoon like this. You describe a requirement to an Agent, and working code appears in minutes. You do it again, and it works again. In one afternoon you finish what used to take two days. Productivity feels like it genuinely leveled up.

Then things start going wrong. You ask the Agent to modify a feature in the existing codebase. It does, but another feature breaks. You ask it to fix that. It does, but a new bug appears. After four or five rounds of this, the time you spend inspecting and patching Agent output exceeds the time you saved.

The problem is not model capability or prompt technique. Improvements on those two dimensions raise the ceiling but do not eliminate it. Over the past two years, models have progressed from GPT-4 to Claude 3.5 Sonnet to Opus 4.6, each generation stronger. You felt the progress: projects you could handle got bigger. Your own skills improved too, with more precise prompts and more targeted context. But every so often, the same collapse pattern reappears at a larger scale. The project gets a little bigger, a few more iterations pile up, and once again changing one thing breaks another. The Agent forgets conventions agreed upon earlier, and output starts drifting from your intent. The ceiling is rising, but the ceiling is still there. A more fundamental structural constraint is at work.

Attention decay over conversation length is one concrete manifestation of this structural constraint. Constraints you set early in a conversation may have no practical influence on Agent output by the end.

Consider an example. At turn five you establish an architectural constraint: all API responses must include an error code field. The Agent complies. The conversation continues for another dozen turns, discussing other features and generating large amounts of code. At turn thirty you ask it to add a new endpoint. The error code field is missing. You scroll back through the conversation, and the constraint is still there at turn five.

The cause is the attention mechanism. Each time an LLM generates a token, it uses attention to review everything in the context, computing a relevance weight for each part and synthesizing the weighted information to make its choice. This weight distribution is not uniform. Research shows that models pay more attention to the beginning and end of the context, with significantly lower recall for the middle (the "lost in the middle" phenomenon). As the conversation grows longer, constraints you set early get sandwiched between ever-increasing volumes of code output and feature discussions. The attention weight they receive drops until it no longer substantively influences Agent output. The information is still in the context, but the Agent effectively cannot see it.

As the conversation grows even longer, compaction is triggered. The system compresses earlier conversation into summaries to free up space. You can see that compaction happened, but you have no control over which information is preserved and which is discarded. The constraint you defined at turn five might become a detail-stripped summary sentence, or it might not appear in the summary at all. Attention decay means the information is present but the Agent cannot see it clearly. Compaction means the information is deleted outright. Together, intent alignment in long conversations rests on a foundation that is constantly eroding.

Attention decay and compaction are only part of the problem you encounter. Behind them is a more complete picture that explains every wall you hit, and explains why the same tools produce such dramatically different results in different hands.

Most developers experience Agent usage much like you do: it feels faster, with an overall productivity gain of 1.5x to 2x. But with the same tools, a few people achieve radically different outcomes. PingCAP CTO Dongxu Huang used AI to rewrite TiDB's PostgreSQL compatibility layer into near-production-quality code. Pigsty founder Vonng maintains an enterprise-grade PostgreSQL distribution integrating over 460 extensions as a solo developer using AI, routinely coordinating ten Agents working in parallel. Their productivity gains are measured in tens of multiples, and the output is verified, production-deployed code.

Same models, same tools, a gap measured in tens of multiples. The difference is engineering discipline. Teams that use Agents at scale have all built a closed-loop control system matched to Agent structural characteristics. They use specs to turn vague intent into precise input, automated verification to check every output, and continuous evolution to keep the system itself from degrading. The industry calls this approach harness engineering.

## Why You Need a Harness

The necessity of a harness comes from the structural differences between Agents as executors and humans. Understanding these differences lets you diagnose every wall you hit, and judge whether your current engineering practices are addressing real problems.

### Structural Characteristics of Agents

Agent behavior is determined by two layers of technical architecture. The bottom layer is the LLM, which generates the most probable next token based on all input content. Each time a token is generated, the model uses attention to review all parts of the input, compute relevance weights for each, and synthesize weighted information to make a choice. The upper layer is the Agentic Loop, which lets the LLM interact with the external world. The Agent receives an instruction, reasons about the next action, invokes tools (read files, execute commands, call APIs), observes the results, reasons again, and acts again. This loop continues until the task is complete. The input and output of each step are appended to the context window.

From these two layers, five structural characteristics of Agents as executors can be derived. Each characteristic is an intrinsic property of the architecture and will not disappear as model capabilities improve.

#### Faithful Execution

An Agent faithfully executes whatever input you give it. Give it a clear, complete spec and the output quality is high. Give it a vague description and every ambiguity compiles into a random decision.

This is a direct consequence of how LLMs work. Output is entirely determined by input. The model processes the text you actually provide, not the intent in your head. Only the portion of your intent that gets written into text and sent into the context influences the output. You tell the Agent to add a search feature. Does the search cover article titles or full text? How are results sorted? What displays when the search query is empty? For every point left unspecified, the Agent fills in whichever option has the highest probability given the current context, then faithfully executes. These choices may diverge from your intent, and you cannot know until you review the output.

A human programmer facing the same vague requirement would draw on business knowledge to fill in the blanks, look at how similar features are implemented in the existing codebase, or simply walk over and ask you. The Agent skips all these completion steps and goes straight from vague input to definite output.

Your team carries a large body of undocumented tacit knowledge that the Agent has no access to. Why a particular module uses a specific design pattern. Why a certain API has its own special error handling logic instead of using the common error handler. What known data format anomalies from a specific client need to be accommodated. Human programmers absorb this knowledge gradually through code review, standups, and daily collaboration. Only knowledge written into the context exists in the Agent's world. The resulting code will functionally and correctly ignore all knowledge not explicitly provided.

Whether you were clear enough can only be judged after seeing the output. How much tacit knowledge you forgot to explicitly provide, you yourself do not know. Under open-loop control, every omission becomes a source of uncertainty in the output.

#### Limited Processing Capacity

Agent working memory has a hard upper bound, and effective capacity is far smaller than the advertised number. The intuition that more information always leads to better results is wrong.

An Agent's entire working memory is the context window. Your instructions, code files, conversation history, and tool return values are all concatenated into a single token sequence fed into the model. This sequence has a length limit, currently ranging from 128K to 1M tokens across mainstream models. That looks large, but advertised capacity and effective capacity are different things. As discussed earlier, attention distribution across the context is not uniform: the beginning and end receive more attention, while recall for the middle drops significantly. The more information present, the less attention weight each piece receives. Past a certain threshold, adding more information has a negative effect, as key constraints get drowned in noise. A window advertised at 128K tokens may have an effective utilization of half or less.

This limitation is especially visible in two scenarios.

The first is large tasks. Small tasks involve a few files and a single feature, and all relevant information fits within effective attention range. The Agent performs well. Large tasks require simultaneously considering database schemas, API contracts, frontend state management, and permission models. The total volume of relevant information exceeds effective capacity, and the Agent starts making trade-offs. Human programmers maintain a persistent mental model of the entire system, keeping global consistency while working on local code. The Agent constructs its understanding from scratch within the limited window each time, and what does not fit is simply ignored.

The second is long chains of reasoning. Each step of the Agentic Loop appends content to the context, so information inside the window grows continuously. An interface design decision made at step 5 gets pushed to the far end of the window by step 50, receiving very low attention weight. A design pattern the Agent adopted in the first half gets silently replaced by a different one in the second half, with the Agent unaware of the contradiction.

Under open-loop control, you are caught between two failure modes. Provide too little information and the Agent lacks necessary context. Provide too much and key information gets buried in noise. You have no reliable way to tell which state you are in.

#### No Memory Accumulation

Agent memory ends at the session boundary. A session starts when you issue an instruction and ends when the task completes or the session closes. During the session, all information accumulates in the context window. When the session ends, the context is cleared and the next session starts from a blank slate. The architectural conventions, pitfalls, and interface agreements you spent twenty minutes teaching it yesterday are all reset to zero today. The hundredth session starts from exactly the same point as the first.

Human team knowledge accumulation works entirely differently. The longer a programmer works on a project, the deeper their understanding. The historical reasons behind architectural decisions, the fragile points in each module, the handling conventions for specific business scenarios: most of this knowledge was never written down, but it lives in team members' heads and transfers naturally through code review, standups, and daily collaboration. Agent-driven development lacks this natural accumulation process.

You can externalize knowledge into documentation to compensate, but documentation itself requires ongoing maintenance. Knowledge in a human brain updates automatically as the project evolves. When you refactor a module, your mental model of that module updates in sync. Documentation does not update itself. An architecture document written three months ago, if no one explicitly maintains it, may no longer match the actual code. Outdated documentation is worse than no documentation, because it provides the Agent with incorrect information that the Agent will faithfully execute.

#### No Consequence Awareness

An Agent's objective function is satisfaction of the current instruction. You ask it to add a feature, it adds it. You ask it to fix a bug, it fixes it. The objective ends there. Long-term code maintainability, technical debt accumulation, and architectural consistency are not part of its optimization objective. A human programmer would think about maintaining this code three months from now and sacrifice some short-term efficiency for readability. Each of the Agent's executions is independent, with the current task's completion as the entire goal.

This characteristic creates a self-reinforcing cycle. When generating new code, the Agent references existing patterns in the codebase. A workaround you left behind during a rush looks to the Agent like an established implementation pattern in the project, and it faithfully copies it into new code. Once merged, that code becomes part of the reference set for subsequent generation, and bad patterns are continuously copied and amplified. A human team typically takes months to a year to accumulate equivalent technical debt. An Agent-driven team can reach that level in weeks. There is no inherent force in the system pushing toward refactoring or quality improvement.

The Agent gives all tasks the same level of attention and speed. Editing copy on a display page and modifying core payment deduction logic look exactly the same at the execution level. Humans instinctively slow down for high-risk operations, add confirmation steps, and pull in a colleague for a second look. The Agent treats all tasks equally. High-risk operations, mixed in among large volumes of low-risk operations, get processed at the same speed.

#### High Throughput at Zero Marginal Cost

The first four characteristics are all manageable problems at human execution speed. You have time to review every PR, re-teach key conventions at the start of each new session, catch a vague spec that produced a deviated implementation, and correct it. Human programmer output speed is itself an error containment mechanism. Slow output means slow deviation accumulation, giving you time to detect and correct deviations before they spread. Code review, architecture evaluation, and integration testing naturally match the cadence of human output.

Agent output speed is 10x to 100x that of a human. At the same time, Agents can be trivially parallelized. Spinning up a second, tenth, or hundredth Agent instance costs nearly nothing, with no hiring, training, or coordination overhead.

This characteristic does not create new problem types on its own, but it amplifies the impact of the first four characteristics by one to two orders of magnitude. A vague spec executed by a human programmer produces two or three deviations that need correction, and you have time to fix each one. The same spec given to an Agent can produce dozens of differently deviated implementations within an hour. No memory accumulation is an inconvenience at two or three sessions per day. At dozens of sessions per day, it becomes severe knowledge fragmentation. No consequence awareness accumulates technical debt over months at human speed. At 100x speed, it reaches the same scale in weeks.

100x speed breaks the cadence match between output and review. Review degrades from line-by-line inspection to spot-checking. Deviations get solidified by dozens of subsequent commits before a human discovers them, becoming new established facts in the codebase. Your last line of defense, manual review, fails in the face of 100x output. You cannot review at 100x speed. Open-loop control is completely unviable at Agent speed and scale.

### The Essence of a Harness

The five characteristics together point to a single need. You need an external, automated, Agent-independent feedback mechanism to replace the capabilities that human executors carry inherently. This mechanism consists of two principles.

**Closed-loop control** makes each execution reliable. A closed loop does two things. First, it uses specs to define clearly what "correct" means, turning the intent in your head into a precise description the Agent can execute against. A spec contains intent (what to do and why), acceptance criteria (how to determine correctness), and constraints (where the boundaries of change are and what should not be touched). With a spec, Agent output goes from unpredictable randomness to a checkable, bounded set. Second, it uses verification to check whether correctness was achieved. Verification is an automated checking mechanism independent of the Agent, catching and correcting deviations at the moment they occur rather than having humans discover them by eye at final delivery. Specs and verification form a feedback loop where deviations are detected and corrected immediately.

**Continuous evolution** keeps the closed loop itself from degrading. Specs, tests, and process documentation form the external knowledge system you build around the Agent, replacing the business knowledge, project memory, and quality awareness that human executors carry inherently. The earlier discussion of no memory accumulation already identified a key problem: externalized knowledge does not update itself. A spec written three months ago, if no one maintains it, may no longer match the current code.

At this point, no memory accumulation and no consequence awareness combine into a dangerous pair. The Agent starts fresh from these documents every session and has no ability to judge whether they are outdated. At the same time, it will not proactively question the documents' validity. An outdated spec guides the Agent to generate code that deviates from current requirements, and once merged, that code becomes the reference baseline for subsequent Agents. The deviation gets institutionalized under the protection of the closed loop. The closed loop, which was supposed to safeguard quality, instead solidifies the error in this scenario.

This is why the closed loop needs a companion principle. Specs, tests, and process documentation all need continuous updating and iteration as the project evolves. Evolution is not extra work outside the closed loop. It is a necessary condition for the closed loop's survival.

Closed-loop control plus continuous evolution: this is the book's complete definition of harness engineering. Not an AGENTS.md file. Not a toolset. An engineering system designed around Agent structural characteristics.

This definition aligns with existing industry practice. HashiCorp co-founder Mitchell Hashimoto was the first to use the term harness engineering. His core approach uses AGENTS.md to guide Agent behavior and programmatic tools to let Agents verify their own output. OpenAI, in a case study where a three-person team generated a million lines of code, defined harness as the complete system surrounding the Agent. Martin Fowler decomposed harness into guides (feedforward control) and sensors (feedback control). These practices are all doing the right thing: AGENTS.md is a form of spec, verification tools are a component of the closed loop, and Fowler's decomposition is one expression of closed-loop structure. What this book provides is the analytical framework behind these practices, so you can understand what structural challenge each component addresses, judge whether your own system is sufficient, and know how to adapt when you encounter new scenarios.

## Book Roadmap

The book unfolds along a productivity ladder, with each volume corresponding to a leap in capability.

Volume One addresses reliability. You are still sitting in front of the Agent in a back-and-forth interaction, but output goes from guesswork to engineered delivery. The specification chapter covers how to turn vague intent into input the Agent can execute precisely. The verification chapter covers how to use automated methods to prove output matches intent. Master these two chapters and you establish a closed loop at the single-interaction level.

Volume Two addresses scale. Only after the closed loop is established can you let Agents execute autonomously. Autonomous execution without a closed loop is YOLO mode, where disaster is certain. Chapter four handles context management and cross-session memory during long-running execution, enabling a single Agent to push complex tasks forward without losing critical information. Chapter five extends to multi-Agent parallelism, addressing isolation and integration. You shift from real-time operator to task designer and acceptance reviewer.

Volume Three addresses organization. Once individual efficiency is no longer the bottleneck, the constraint moves to the team level. Division of labor, processes, and role definitions were all designed for human execution speed and need to be re-matched to the cadence of the Agent era. The engineering practices established in Volumes One and Two are the infrastructure for organization-level collaboration. Without this infrastructure, team-level Agent collaboration has no foundation.

Three types of readers can start from different entry points. If you are an engineer transitioning from writing code yourself to directing Agents, start with Volume One and follow the productivity ladder all the way up. If you are a product person or a programming newcomer who has already built a working product through Vibe Coding, the specification and verification chapters in Volume One will help you directly. If you are a technical leader driving your team's AI transformation, start with Volume Three to understand organizational challenges, then go back to Volumes One and Two for the engineering foundations that support organizational change.

---

*Harness Engineering Playbook · [AgentsZone](https://agentszone.ai) Community*
