# Context Pollution Concept
**Source:** brainstorm.md (2026-03-12), lines 395-610

## 核心概念：Context Pollution（上下文污染）

### 定义

**Context Pollution = AI的工作质量被错误/过时/矛盾的上下文信息腐蚀。**

社区讨论长期聚焦在"如何给AI足够的上下文"（Context Engineering），但忽略了对称的问题：**错误的上下文比没有上下文更危险。** 更多文档不等于更好的结果——更多文档 = 更多潜在的污染源。

这个概念把叙事从"how to give AI enough context"翻转为"how to prevent bad context from corrupting AI's work"。

### 污染源分类

#### 1. 过时污染（Stale Pollution）
**来源**：派生视图（六分类法类型4）——过时的架构图、README、注释、API文档
- AI读到过时的架构图 → 基于错误的系统理解生成代码
- OpenAI每周五清理"AI slop"就是在做**去污染**
- 胥克谦："如果存在半成品文档，跟程序不一致了，很麻烦的"
- **Harness Engineering的Entropy Management本质上是anti-pollution mechanism**

#### 2. 冲突污染（Conflict Pollution）
**来源**：多源信息的优先级不明确
- Ring 3的Stack Overflow答案和Ring 0的安全规则矛盾 → AI按Ring 3执行 = 被污染
- PRD说"用PostgreSQL"，架构文档说"优先MongoDB" → AI随机选择
- Slack讨论改了需求但PRD没更新 → AI按旧PRD工作
- **薇冷Violet的Ring 0-3信任环就是为了解决冲突污染——明确"听谁的"**

#### 3. 推理污染（Inference Pollution）
**来源**：需要跨文档推理的分层结构
- 胥克谦的核心论点："分层是给我们用的，不是给LLM用的"
- 分层结构要求LLM做跨层推理，每次推理都有出错概率
- 错误推理产生错误结论 → 基于错误结论生成代码
- **解法是"解压缩"——设计时分层，执行时展开为单一文档**

#### 4. 压缩污染（Compaction Pollution）
**来源**：Dangerous Compaction过程中的选择性信息损失
- Compaction不是均匀丢信息，而是选择性丢弃
- 可能保留错误信息而丢弃正确信息 = **选择性污染**
- 压缩后AI基于残缺上下文做出的决策，可能比没有上下文更糟
- **这是有限理性（Herbert Simon）的病态版本——不是信息不够，而是信息被扭曲**

#### 5. 共谋污染（Collusion Pollution）
**来源**：AI写代码 + AI写测试 = Ground Truth Problem
- AI生成的测试"验证"AI生成的代码 = 用污染的验证器去验证污染的产出
- 测试成了实现的镜子（Swizec Teller），而非独立的真相来源
- Kent Beck发现AI会删除测试来"通过"测试——**AI主动制造共谋污染**
- **解法：测试必须锚定在人类写的验收标准（Layer 1）上，而非AI生成的代码上**

#### 6. 遗留污染（Legacy Pollution）
**来源**：棕地项目中的历史代码和文档
- 遗留代码中的过时模式被AI学习并复制
- 已废弃但未删除的API被AI调用
- 旧注释描述的行为和实际代码行为不一致
- **社区问题中反复出现的"棕地项目怎么用AI"本质上是legacy pollution问题**

### 理论映射

| 理论体系 | Context Pollution的对应概念 |
|---------|--------------------------|
| **信息论** | Channel Noise (Shannon) — 上下文污染 = 通信噪声，降低信号信噪比 |
| **控制论** | Sensor Corruption — 反馈回路中传感器被污染，闭环控制变成基于错误信号的失控 |
| **分布式系统** | Byzantine Fault — 节点不是"不工作"，而是"给出错误信息"，比crash fault更难处理 |
| **管理学** | Organisational Misinformation — 错误信息比没有信息更有害（rumour mill effect） |
| **进化论** | Muller's Ratchet — 无性繁殖群体中有害突变只能累积不能消除 |

### Byzantine Fault类比的深层含义

分布式系统中，故障分两种：
- **Crash Fault**（崩溃故障）：节点停止工作 → 容易检测（AI报错/超时）
- **Byzantine Fault**（拜占庭故障）：节点继续工作但给出错误结果 → 极难检测（AI自信地给出错误答案）

Context Pollution导致的正是**Byzantine behaviour**——AI不是不工作，而是**基于被污染的上下文，自信地、流畅地产出错误结果**。这比"AI报错"危险得多，因为：
1. 人无法从输出的流畅程度判断正确性
2. AI不会说"我不确定"（不像crash会给出明确错误信号）
3. 错误输出可能长时间不被发现，累积成系统性债务

这解释了为什么社区反复出现"AI偷懒/欺骗"的抱怨——**很多不是AI"故意"偷懒，而是基于被污染的上下文做出了看似合理但实际错误的决策。**

### Anti-Pollution Mechanisms（去污染机制）

将现有实践重新框架为anti-pollution：

| 机制 | 针对的污染类型 | 实现方式 |
|------|-------------|---------|
| **Entropy Management** (Harness Engineering) | 过时污染 | 周期性清理agent、自动检测不一致 |
| **Ring 0-3信任环** | 冲突污染 | 明确信息优先级 |
| **文档解压缩** (胥克谦) | 推理污染 | 执行时展开为单一文档 |
| **文档分层/分级** | 压缩污染 | P0/P1/P2/P3确保关键信息不被丢弃 |
| **TDD（人写标准）** | 共谋污染 | 测试锚定在人类验收标准上 |
| **回归测试** | 遗留污染 | 自动检测代码变更是否破坏已有行为 |
| **六分类法** | 全部 | 不同类型文档不同管理策略，按过时风险差异化清理 |
| **Golden Principles** (OpenAI) | 冲突污染 | 机械化、可自动检查的铁律 |
| **Git版本管理** | 过时污染 | 文档和代码同步版本化 |
| **Change Logs** (prd-change-log.md) | 冲突污染 | 记录修改历史，减少PRD漂移 |

### Context Pollution在五层模型中的位置

Context Pollution**不属于任何一层，而是贯穿所有层的交叉关切(cross-cutting concern)**：

- **Layer 1** 污染：PRD过时或模糊 → 后续所有层都建立在错误基础上（最致命）
- **Layer 2** 污染：测试与代码共谋 → 验证机制本身被污染（Ground Truth Problem）
- **Layer 3** 污染：Dangerous Compaction丢失关键上下文 → agent基于不完整信息决策
- **Layer 4** 污染：对抗角色读到的标准本身有误 → 审查基于错误标准（"谁来监督监督者"的信息版本）
- **Layer 5** 污染：共享skill中的过时实践 → 组织级别传播错误模式

### 与已有材料的连接

**与"评估是进化的前提"(root brainstorm)的连接**：
- 好的评估函数 → 适应性进化
- 坏的评估函数 → 恶性变异（Wells Fargo, 苏联钉子）
- **被污染的评估函数 → 更糟——系统朝错误方向"进化"，还以为自己在改进**

**与Goodhart定律的连接**：
- Goodhart说"指标成为目标时就不再是好指标"
- Context Pollution的版本：**当上下文成为AI的唯一世界观时，上下文中的任何错误都会成为AI的"真理"**

**与Campbell定律的连接**：
- Campbell说评估越重要，越容易被腐蚀
- 同理：上下文越被AI信任，上下文中的错误越危险

### 悖论6：更多上下文可能导致更差的结果

这是Context Pollution的核心悖论：
- Context Engineering说"给AI更多上下文"
- 但更多上下文 = 更多污染源 = 更多Byzantine fault的可能性
- 最优点不是"最大上下文"而是"最干净的上下文"
- **与探索-利用权衡类似，存在一个最优的"上下文量"——少了信息不足，多了噪声淹没信号**

这和信息论中的channel capacity直接对应：每个通信信道都有一个最大信息传输率，超过这个率，错误率急剧上升。Context window就是AI的channel capacity——关键不是塞满它，而是在容量内最大化信噪比。

### 外部研究验证（2025-2026）

Context Pollution不是我们独创的——社区已经从多个角度在研究这个问题。以下是关键发现：

#### Drew Breunig的四种Context失败模式（最清晰的分类）
Source: https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html

1. **Context Poisoning** — 幻觉或错误进入上下文后被反复引用，错误复合放大。Agent被锁定在不可能的目标上
2. **Context Distraction** — 上下文增长到模型过度聚焦于它，忽略训练知识。Agent重复过去的行为而非推进
3. **Context Confusion** — 多余信息被模型用来生成低质量回复
4. **Context Clash** — 新信息和工具与prompt中已有信息冲突

**与我们六种污染类型的映射**：
- Poisoning ≈ 我们的共谋污染 + 遗留污染（错误信息进入并累积）
- Distraction ≈ 过时污染（过多irrelevant信息分散注意力）
- Confusion ≈ 推理污染（多余信息导致低质量推理）
- Clash ≈ 冲突污染（信息互相矛盾）
- 我们的"压缩污染"是Breunig没有覆盖的——这是AI coding特有的，因为compaction是coding agent的核心机制

#### Chroma的Context Rot实证研究（最严谨的量化证据）
Source: https://research.trychroma.com/context-rot

测试了18个前沿模型。**每一个模型在输入长度增加时表现都变差——即使远未达到token限制。** 三个复合机制：
1. Lost-in-the-middle效应：相关信息在中间时准确率下降30%+
2. 二次方注意力缩放
3. 语义相似的干扰内容

Stanford研究：仅20个检索文档（约4000 tokens）就让准确率从70-75%降至55-60%。

**关键意义：这是"更多上下文可能导致更差结果"悖论的实证证明。**

#### ETH Zurich的AGENTS.md研究（2026年2月）
Source: https://www.marktechpost.com/2026/02/25/new-eth-zurich-study-proves-your-ai-coding-agents-are-failing-because-your-agents-md-files-are-too-detailed/

在138个真实GitHub任务中，**LLM生成的context文件比完全没有context时成功率降低约3%，同时推理成本增加20%以上。** "AI agents are too obedient" — 它们遵循不必要的指令反而让任务更难。代码库概览对agent导航没有帮助——agent自己发现文件结构的效率更高。

**关键意义：这直接证明了context pollution的实际危害——精心编写的指导文档不仅没用，还有害。**

#### Kurtis Kemple的Context Pollution度量框架
Source: https://kurtiskemple.com/blog/measuring-context-pollution/
（Slack DevRel高级总监）

提出用cosine similarity度量原始任务意图和当前工作上下文之间的距离。1.0 = 完美对齐，分数降低 = 污染增加。三个组件：drift curve、eval outcome、interaction pattern。

**关键意义：这是唯一一个量化测量context pollution的框架。**

#### Philipp Schmid (Hugging Face) 的Context Engineering分类
Source: https://www.philschmid.de/context-engineering-part-2

将Context Pollution定义为"上下文中存在太多不相关、冗余或矛盾的信息，分散LLM注意力并降低推理准确性"。特别指出**多agent系统尤其脆弱**——子agent共享同一上下文既造成KV-cache惩罚，又混淆模型。

#### Manus AI的实践解法
Source: https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus

解法借鉴Go并发模型："Share memory by communicating, don't communicate by sharing memory." 开发了工具调用的full/compact双格式——compact版本剥离可从文件系统重建的信息。

**关键意义：这个解法和胥克谦的"解压缩"论异曲同工——不是共享全部上下文，而是每个agent只获取自己需要的。**

#### Codified Context论文 (arXiv, 2026年2月)
Source: https://arxiv.org/html/2602.20478v1
作者：Aristidis Vasilopoulos

核心发现：单文件manifest (CLAUDE.md, .cursorrules) 在中等以上代码库中就不再scale。提出三层架构：hot-memory constitution、specialized domain-expert agents、cold-memory knowledge base。**关键发现：specification staleness是首要失败模式** — 实现变了但spec没更新，AI基于过时信息生成代码。维护spec每周约需1-2小时。

#### Andrew Ng的Context Hub
Source: https://earezki.com/ai-news/2026-03-09-andrew-ngs-team-releases-context-hub/

解决API drift问题——LLM训练后就"冻结在时间中"，推荐已废弃的endpoint。Context Hub是开源CLI，为coding agent提供最新的API文档。

### Context问题的术语全景

| 术语 | 提出者 | 含义 | 与我们框架的关系 |
|------|--------|------|-----------------|
| **Context Pollution** | Kemple, Schmid, Manus | 不相关/冗余/矛盾信息降低推理质量 | 我们的umbrella term |
| **Context Rot** | Chroma Research | 输入长度增加导致性能下降（即使在限制内） | 我们的"压缩污染"的量化证据 |
| **Context Drift** | Tacnode, Lumenalta | 随时间逐渐偏离原始意图 | 我们的"过时污染"的动态版本 |
| **Context Poisoning** | Breunig, Microsoft, OWASP | 错误/恶意内容进入上下文并复合放大 | 我们的"共谋污染" + 安全维度 |
| **Context Confusion** | Breunig, Schmid | 模型无法区分指令和数据 | 我们的"推理污染" |
| **Context Clash** | Breunig | 上下文中的矛盾信息 | 我们的"冲突污染" |
| **Context Distraction** | Breunig | 过度聚焦上下文忽略训练知识 | 新发现——我们没有覆盖的类型 |
| **Spec Staleness** | Vasilopoulos | Spec和实现不同步 | 我们的"过时污染"在spec层面 |
| **Agent Drift** | Andrew Ng团队 | AI推荐已废弃的API | 我们的"遗留污染"的API版本 |

**关键发现：Context Pollution是最通用的umbrella term，涵盖大部分子现象。我们的六种分类（过时、冲突、推理、压缩、共谋、遗留）比Breunig的四种更全面，特别是"压缩污染"和"共谋污染"是AI coding特有的。**

**Breunig的"Context Distraction"是我们需要补充的一种新类型**：AI过度聚焦上下文中的信息，忽略了自己训练时学到的知识。这在实践中表现为：给AI太多项目文档后，它反而不使用自己对通用最佳实践的理解了。
