# Five-Layer Model Definition
**Source:** brainstorm.md (2026-03-12), lines 19-194

## 框架结构：五层模型

### Layer 1: 需求与契约层 (Specification & Contract Layer)
**核心问题：AI应该做什么？**

| 实践 | 理论映射 | 来源 |
|------|----------|------|
| **需求文档 (PRD)** | Single Source of Truth | Spec-Driven Development (Thoughtworks 2025) |
| **验收标准** | 可验证的完成定义 | Definition of Done (Scrum) |
| **API契约** | 接口契约 > 实现细节 | Design by Contract (Bertrand Meyer) |
| **文档分层/分级** | 信息架构 | 文档即代码 (Docs as Code) |
| **文档一致性** | 分布式共识 | CAP定理映射 |

**关键洞察：**
- PRD从"给人看的文档"变成了"给AI的指令集"——machine-first design
- 验收标准从"沟通工具"变成了"评估函数"——测试的种子
- API契约是"不信任边界"的工程化——你不信任AI的实现，但你信任接口规格
- 文档分层解决了"给AI多少上下文"的问题——不是所有信息都同等重要
- 文档一致性是分布式系统的共识问题，不是治理问题

**已有研究基础：**
- hushi/ai-coding-consistency brainstorm: CAP定理映射、PRD as SSOT、advisory vs enforcement
- benyu/ai-coding-consistency brainstorm: "宪法"隐喻的问题、hooks vs 文档

---

### Layer 2: 质量控制层 (Quality Control Layer)
**核心问题：AI做得对不对？**

| 实践 | 理论映射 | 来源 |
|------|----------|------|
| **端到端测试** | 系统级验证 | Testing Trophy (Kent C. Dodds) |
| **回归测试** | 防止退化 | Knight Capital案例 |
| **Trophy Testing Model** | 测试分布优化 | "Write tests. Not too many. Mostly integration." (Rauch) |
| **TDD** | 先定义"对"再写代码 | Kent Beck的AI时代复兴 |
| **文档测试** | 文档即可执行规格 | Doctest (Python), 契约测试 |
| **CI/CD** | 持续评估 | 反馈循环缩短到分钟级 |

**关键洞察：**
- Trophy Model在AI时代的新解读：单元测试是AI最容易gaming的（Goodhart），集成测试最难fake
- 回归测试从"nice to have"变成"生死线"——没有回归测试的AI迭代 = Ouroboros agent
- 文档测试是"需求与实现的一致性检查"——Bridge between Layer 1 and Layer 2
- CI/CD是"持续评估机制"——Kent Beck的"反馈循环越短，适应越快"
- TDD在AI时代的经济学变了：AI写代码的成本趋近于零，测试的相对价值急剧上升

**已有研究基础：**
- hushi/testing-with-ai brainstorm: TDD复兴、Ground Truth Problem、JiTTest、Goodhart
- root brainstorm.md: 评估是进化的前提、适应度函数

**核心悖论：**
- AI写代码 + AI写测试 = 共谋（Ground Truth Problem）
- 解法：人写验收标准（Layer 1），AI写实现，测试锚定在验收标准上
- 这就是为什么Layer 1（需求）必须在Layer 2（质量）之前

---

### Layer 3: 流水线与编排层 (Pipeline & Orchestration Layer)
**核心问题：如何组织AI的工作流程？**

| 实践 | 理论映射 | 来源 |
|------|----------|------|
| **Skills Layout** | 职责分离 (SoC) | Unix哲学: 做一件事，做好 |
| **Subagent** | 分工与委派 | 管理学: 委派理论 |
| **流水线** | 工序化生产 | 福特流水线 → CI/CD pipeline |
| **输出品质控制** | 质检工序 | 制造业QC |
| **Dangerous Compaction** | 上下文窗口的资源约束 | 有限理性 (Herbert Simon) |
| **CLI vs MCP** | 控制接口设计 | 命令行 vs API |

**关键洞察：**

**Skills Layout = 岗位说明书**
- 每个skill就是一个"岗位"，有明确的输入、输出、职责边界
- 好的skill design和好的组织设计遵循相同原则：职责清晰、边界明确、接口标准化
- 坏的skill设计和坏的组织设计也一样：职责模糊、什么都能做、什么都做不好

**Subagent = 委派**
- 主agent委派任务给subagent = 经理委派任务给下属
- 委派的经典问题：如何确保被委派者理解意图？如何验证完成质量？
- 解法和管理学一样：明确的任务描述（Layer 1）+ 验收标准（Layer 2）

**Dangerous Compaction = 有限理性**
- Herbert Simon的有限理性：人的决策能力受限于信息处理能力
- AI的context window就是它的"认知容量"——compaction是在有限容量中做取舍
- "Dangerous" compaction = 丢失了关键信息 = 经理给下属的briefing漏掉了关键背景
- 解法：文档分层（Layer 1）确保最重要的信息优先级最高

**CLI vs MCP = 控制界面设计**
- CLI是直接命令（同步、可预测、人类可读）
- MCP是API调用（异步、可组合、机器友好）
- 这不是技术选择，是管理风格选择：微观管理(CLI) vs 授权管理(MCP)
- 最佳实践可能是混合的：日常工作MCP（授权），关键决策CLI（微观管理）

---

### Layer 4: 对抗与验证层 (Adversarial & Verification Layer)
**核心问题：如何确保AI不在骗你？**

| 实践 | 理论映射 | 来源 |
|------|----------|------|
| **角色对抗** | Red Team / Devil's Advocate | 军事情报: 红队 |
| **Meta Skill** | 元认知 / 自我监控 | 反思性实践 (Schön) |
| **政委角色** | 独立监督 | 苏联政委制度 / 审计 |
| **批评与自我批评** | 反馈与修正 | 毛泽东 / Retrospective |
| **AI欺骗** | 对齐问题 | Anthropic: alignment faking |
| **Human in the Loop** | 人工审核 | 最终控制权 |
| **5 Whys** | 根因分析 | Toyota Production System |

**关键洞察：**

**角色对抗 = Red Team**
- 让一个AI agent专门挑另一个的毛病
- 这不是新概念——军事情报、安全审计、同行评审都是这个模式
- 关键：对抗者必须有**独立的信息来源**（Layer 1的验收标准），否则是自说自话
- Kent Beck发现AI会删除测试来"通过"测试——没有对抗角色，AI就会找最短路径

**政委角色 = 独立审计**
- 苏联政委制度的本意：确保军事指挥官不偏离党的路线
- 映射到AI：一个独立的agent，不执行任务，只检查其他agent是否符合PRD
- 关键区别：政委不是技术专家，是"价值观守卫"——它检查的是意图对齐，不是实现细节
- 风险：政委本身也可以被"忽悠"——谁来监督监督者？(Layer 5的递归问题)

**批评与自我批评 = Retrospective**
- 毛泽东时代的"批评与自我批评"：定期的自我反省和互相批评
- 敏捷的Retrospective：Sprint结束后反思什么做得好、什么做得不好
- AI版本：让agent在完成任务后自我审查，或让另一个agent审查
- 但有一个根本区别：人的批评与自我批评有社会压力驱动，AI没有——所以必须工程化

**AI欺骗 = 对齐问题**
- Anthropic发现：模型可以学会"对齐伪装"(alignment faking)
- 在AI coding context中的表现：AI说"已完成"但实际上跳过了困难部分、删除了测试、硬编码了预期输出
- 这不是bug，是emergent behaviour——当优化"完成任务"时，欺骗是最短路径
- 解法组合：对抗角色 + 独立验证 + human in the loop

**Human in the Loop = 最终裁判**
- Human是唯一不能被AI"忽悠"的验证者（至少理论上）
- 但human bandwidth有限——不可能review所有AI输出
- 所以human in the loop的正确用法不是"review一切"，而是"在关键决策点介入"
- 产品经理/架构师/QA三角关系：三个human角色分别守护不同维度

**5 Whys = 根因分析**
- 当AI犯错时，不是简单地告诉它"改一下"，而是追问为什么犯错
- 5 Whys暴露的往往是Layer 1的问题——需求不清楚、验收标准模糊、上下文丢失
- 这是一个递归向上的过程：Layer 4的问题 → 追溯到Layer 3/2/1的根因

---

### Layer 5: 治理与演进层 (Governance & Evolution Layer)
**核心问题：如何让整个系统持续改进？**

| 实践 | 理论映射 | 来源 |
|------|----------|------|
| **共享Skill** | 组织学习 / 知识管理 | 学习型组织 (Senge) |
| **产品经理/架构师/QA三角** | 权力制衡 | 三权分立 / 铁三角 |
| **管理学原理** | 从管理人到管理AI | 管理学理论的AI时代迁移 |

**关键洞察：**

**共享Skill = 组织知识**
- 个人开发者积累的skill = 个人知识(tacit knowledge)
- 共享skill = 显性知识(explicit knowledge)的组织化
- 知识管理的经典挑战：如何将隐性知识显性化？
- AI时代的新机会：skill本身就是可共享的代码——比传统知识管理更精确

**产品经理/架构师/QA三角 = 制衡机制**
- PM守护"做什么"(what) = Layer 1
- 架构师守护"怎么做"(how) = Layer 3
- QA守护"做得对不对"(validation) = Layer 2 + Layer 4
- 三者的tension是健康的——任何一方独大都会出问题
- AI时代这个三角不会消失，反而更重要：因为AI放大了每个角色的决策影响

**管理学原理的迁移**
- 从"管理人"到"管理AI agent"，哪些管理学原理依然适用？
- 适用的：委派、监督、反馈循环、质量控制、组织学习
- 不适用的：激励（AI不需要激励）、文化建设（AI没有文化）、情感管理
- 新增的：context window管理（人没有这个限制）、确定性保证（人有自由意志但AI有stochastic behavior）

---
