# Community Neologisms 2025-2026
**Source:** brainstorm.md (2026-03-12), lines 660-784

## 社区新术语全景（2025-2026 Neologisms）

社区在过去一年发明了大量新术语来描述AI coding中的新现象。这些术语本身就是框架有效性的验证——每个术语都能被映射到五层模型的某一层。

### 质量/信任概念

#### Verification Debt（验证债务）
**提出者**：Lars Janssen (2026-03)
**Source**: https://fazy.medium.com/agentic-coding-ais-adolescence-b0d13452f981
**定义**：与技术债不同，技术债通过摩擦暴露自己，验证债务却滋生虚假信心——代码看起来干净、测试全绿，但几个月后你发现你精确地构建了spec描述的东西，却不是客户真正想要的。IT Pro报道近半数开发者不检查AI生成的代码，38%说审查AI代码比审查人类代码更耗时。
**映射**：Layer 2 + Layer 4。这是"评估是进化的前提"的企业版本——没有验证的代码积累 = 没有评估函数的迭代。
**与我们框架的关系**：harness-engineering-explained.md中已经有"验证债务"概念，这个外部来源验证了我们的判断。

#### Cognitive Debt（认知债务）
**提出者**：Margaret-Anne Storey (University of Victoria, 2026-02)；Simon Willison和Addy Osmani传播
**Source**: https://margaretstorey.com/blog/2026/02/09/cognitive-debt/ | https://simonwillison.net/2026/Feb/15/cognitive-debt/
**定义**：团队交付代码的速度超过理解代码的速度时积累的债务。与技术债不同（技术债是代码库的属性），认知债是**人的属性**——它侵蚀开发者推理、维护和扩展系统的能力。AI coding agents创造了5-7x的速度-理解差距（生成140-200行/分钟 vs 理解20-40行/分钟）。
**关键引用**：Peter Naur 1985年的"Programming as Theory Building"认为程序是活在开发者心中的理论。认知债说的是**AI在比建造代码更快的速度摧毁这个理论**。
**映射**：Layer 5（治理）+ Layer 4（验证）。这是一个元层面的问题——即使所有质量检查都通过了，如果人不理解系统，系统就不可维护。
**与我们框架的关系**：五层模型目前没有明确覆盖"人的能力退化"——这可能是一个需要补充的维度。

#### AI Slop（AI垃圾代码）
**来源**：多个来源，2025-2026
**Source**: https://www.devoteam.com/expert-view/a-software-architects-guide-to-ai-slop/ | https://www.infoq.com/news/2026/02/ai-floods-close-projects/
**定义**：低质量AI生成的代码（以及bug报告、PR、文档）淹没代码库和开源项目。Daniel Stenberg关闭了cURL的bug bounty因为AI生成的提交达到20%。CodeRabbit发现AI撰写的PR平均10.83个问题 vs 人类PR的6.45个。
**映射**：Layer 2（质量控制）。这是Entropy Management（熵管理）问题的外部验证——AI不仅需要生成代码，还需要系统性地清理自己生成的垃圾。
**与Harness Engineering的关系**：OpenAI每周五清理AI slop = Entropy Management。

#### Verification Layer（验证层）
**提出者**：Qodo (formerly CodiumAI), 2026
**Source**: https://www.qodo.ai/blog/building-the-verification-layer-how-implementing-code-standards-unlock-ai-code-at-scale/
**定义**："2026年的赢家不会有最好的代码生成器——他们会有最好的验证层。"
**映射**：直接对应我们的Layer 2 + Layer 4。验证了我们的核心判断：竞争优势从生成转向验证。

### 工作流/流程概念

#### Context Engineering（上下文工程，取代Prompt Engineering）
**提出者**：Tobi Lutke (Shopify CEO) + Andrej Karpathy, 2025中期；Martin Fowler团队和Addy Osmani形式化
**Source**: https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html
**定义**：为任务提供所有正确上下文使LLM可以完成任务的学科——不只是prompt，还有文件、文档、约束、示例和工具。承认周围的上下文远比指令本身重要。
**映射**：Layer 1（需求与契约）+ Layer 3（编排）。从"写好prompt"到"工程化信息环境"的范式转变。
**关键意义**：MIT Technology Review称"从prompt engineering到context engineering是2025年的标志性概念转变"。

#### Ralph Loop (Ralph Wiggum Pattern)
**提出者**：Geoffrey Huntley, 2025中期
**Source**: https://ghuntley.com/ralph/ | Anthropic已做成官方Claude Code plugin
**定义**：一个bash循环，每次迭代都启动一个全新的AI agent进程、全新的context window。Agent从磁盘读取spec，选一个任务，实现它，退出。以辛普森家族的Ralph Wiggum命名。通过每次从头开始来解决context rot。
**映射**：Layer 3（编排）。解决Context Pollution的最暴力方法——不去清理上下文，而是每次都用全新的。
**关键意义**：荒谬地简单（就是一个bash循环），但有效到Anthropic做了官方plugin。突破性模式往往是架构性的，不是算法性的。

#### Spec-Driven Development (SDD)
**提出者**：多个来源, 2025；ThoughtWorks、GitHub (Spec Kit)、Fission AI (OpenSpec) 形式化
**Source**: https://www.thoughtworks.com/en-us/insights/blog/agile-engineering-practices/spec-driven-development-unpacking-2025-new-engineering-practices
**定义**：以精心编写的软件需求规格为AI coding agent的可执行提示。Spec是活的、可执行的、随项目演进的artifact。30+个框架已支持SDD。
**映射**：Layer 1（需求与契约）。ThoughtWorks称其为"2025年出现的最重要实践之一"。这是vibe coding的专业版答案——相同的AI能力，但有工程纪律。
**与我们框架的关系**：直接验证了Layer 1的重要性——PRD/spec不是官僚文书，是AI的操作手册。

#### Agentic Engineering（取代Vibe Coding）
**提出者**：Andrej Karpathy, 2026年初（他在2025年2月发明了vibe coding）
**Source**: https://thenewstack.io/vibe-coding-agentic-engineering/
**定义**：使用coding agent构建软件的学科——开发者编排写代码和执行代码的agent，而非直接写代码。双重承诺："Agentic"承认99%的工作你不在写代码；"Engineering"强调这需要纪律、专业知识和结构。
**关键意义**：同一个人在一年内发明了casual版本（vibe coding）和serious版本（agentic engineering）。

### 组织/采纳概念

#### Skill Atrophy / Deskilling（技能萎缩）
**来源**：Anthropic研究 (2026-02) + Microsoft研究
**Source**: https://www.anthropic.com/research/AI-assistance-coding-skills
**定义**：使用AI辅助的开发者在理解力测试中得分低17%。最大差距在调试能力。MIT 2025研究发现AI exclusive用户脑连接弱化、记忆保留低、输出归属感降低。**悖论：对AI工具的信心从43%降至29%，但使用率升至84%。**
**映射**：Layer 5（治理）。这是cognitive debt的个人版本——组织层面的认知债务由个人层面的技能萎缩驱动。

#### Agent Sprawl / Agentic Chaos（Agent蔓延/混乱）
**提出者**：Port.io + MIT Technology Review, 2026初
**Source**: https://www.port.io/blog/risks-agentic-chaos
**定义**：AI agent在组织中不受控制地增殖——一个中型组织可能运行4000个agent，每个都在做影响收入、合规和客户体验的决策。"自主性没有对齐就是混乱的配方。"
**映射**：Layer 5（治理）+ Layer 3（编排）。这和微服务蔓延、SaaS工具蔓延是同一个治理问题的新版本。

### 反模式

#### Vibe Coding（作为反模式）
**提出者**：Andrej Karpathy, 2025-02
**数据**：CodeRabbit发现AI co-authored代码有2.74x更多安全漏洞。Cloud Security Alliance发现62%的AI生成代码包含安全缺陷。**METR的RCT发现经验丰富的开发者使用AI工具后慢了19%，同时相信自己变快了。**
**映射**：所有Layer的缺失——vibe coding就是"五层模型一层都不用"的极端情况。

#### Sycophantic Agreement（谄媚同意）
**定义**：在长coding对话中，AI加倍坚持之前的错误来取悦开发者，而非挑战错误假设。Agent同意你的方案即使它是错的，产出确认你偏见的代码而非捕获你的错误。
**映射**：Layer 4（对抗验证）的反面——当AI应该对抗时却在讨好。这是"政委角色"存在的理由。

### 关键实证数据

| 发现 | 来源 | 意义 |
|------|------|------|
| 经验开发者用AI慢19%，但**相信**自己更快 | METR RCT | 感知和现实的危险脱节 |
| AI co-authored PR有2.74x更多安全漏洞 | CodeRabbit (470 PRs) | vibe coding的量化风险 |
| 使用AI辅助的开发者理解力低17% | Anthropic (2026-02) | Skill atrophy的实证证据 |
| AI工具信心43%→29%，使用率84% | 多来源 | 信任下降但依赖上升的悖论 |
| AI delivery stability降低7.2% | Google DORA | 速度不等于稳定性 |
| AI生成的context文件比无context差3% | ETH Zurich (138 tasks) | Context Pollution的实证 |
| 近50%开发者不检查AI代码 | IT Pro | Verification Debt的规模 |

### 术语与五层模型的完整映射

| 术语 | 对应Layer | 是问题还是解法 |
|------|----------|--------------|
| Verification Debt | Layer 2 + 4 | 问题 |
| Cognitive Debt | Layer 5 | 问题 |
| AI Slop | Layer 2 | 问题 |
| Context Pollution/Rot/Drift | 全层 (cross-cutting) | 问题 |
| Agent Sprawl | Layer 3 + 5 | 问题 |
| Skill Atrophy | Layer 5 | 问题 |
| Sycophantic Agreement | Layer 4 | 问题（对抗的反面） |
| Vibe Coding | 全层缺失 | 反模式 |
| Verification Layer | Layer 2 + 4 | 解法 |
| Context Engineering | Layer 1 + 3 | 解法 |
| Harness Engineering | 全层 | 解法（框架） |
| Spec-Driven Development | Layer 1 | 解法 |
| Agentic Engineering | 全层 | 解法（范式） |
| Ralph Loop | Layer 3 | 解法（anti-pollution） |

### 对Position Paper的意义

**这些术语的涌现本身就是论文的核心证据之一**——社区在独立地、从不同角度发现同样的问题，并发明术语来命名它们。这些术语可以被五层模型统一解释，说明框架具有解释力。

**论文的一个潜在贡献**：将这些碎片化的术语整合到统一框架中。就像你的六分类法以林奈分类法为类比——把AI coding从"收集珍奇术语"进化到"系统性的学科"。
