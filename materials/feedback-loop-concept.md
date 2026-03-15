# Feedback Loop Concept
**Source:** brainstorm.md (2026-03-12), lines 993-1139

## 核心概念：Feedback Loop（反馈循环）

### 为什么Feedback Loop是框架的核心机制

五层模型描述的是**结构**（有哪些层），但不能只有结构——层与层之间、层内部、以及整个系统和外部世界之间，都需要**反馈循环**来运转。没有反馈循环的五层模型就是一堆静态文档。

**反馈循环是五层模型的血液循环系统——结构是骨骼，反馈是血液。**

Wiener (1948) 定义控制论为"控制与通信理论"。核心机制就是反馈：系统的输出被测量并反馈到输入端，用于调整行为。没有人在Wiener之前把"基于信息的反馈与调整机制驱动系统并保持稳定"作为一个统一的范畴来认识。

### 反馈循环的两种类型

**负反馈（Negative Feedback）= 纠错**
- 减少实际状态和期望状态之间的偏差——稳定力量
- AI coding中的表现：测试捕获错误、linter纠正风格、CI拒绝坏代码
- 这是我们**需要**的模式

**正反馈（Positive Feedback）= 放大**
- 放大变化，导致指数增长或衰退——潜在的失控
- AI coding中的病态表现：AI错误复合放大、sycophantic agreement强化错误决策、AI生成的代码被合并后成为内部参考集 → AI看到这些模式视为被认可 → 自我强化的质量下降循环
- 这是我们**需要防止**的模式
- MojoTech研究："加速的代码质量退化、指数级安全漏洞增长、不可持续的维护负担将在2026-2027年达到危机水平"

### 三环反馈模型（Three Developer Loops）

IT Revolution (2025) 提出三环框架，Martin Fowler团队进一步阐述：

**Inner Loop（内环）— 秒到分钟**
- Agent的自主循环：计划 → 执行 → 观察 → 修正
- 频率：每几分钟commit一次（比传统开发快4x）
- Chris Lattner：edit-compile-run-test循环应在30秒内
- **这是TDD红-绿-重构循环在AI时代的加速版**

**Middle Loop（中环）— 小时到天**
- Session之间的上下文管理
- 人类review和方向调整
- 跨session反馈的持久化（progress files, change logs）
- **这是Context Pollution最容易发生的地方——中环的信息质量决定了内环的工作质量**

**Outer Loop（外环）— 周到月**
- 战略架构和长期设计决策
- "慢外环（项目生命周期、利益相关者关系、战略判断）保持人类主导，AI运行内环并向上反馈情报"
- 组织学习、Skill迭代、流程改进
- **Layer 5（治理与演进）主要在这个环操作**

### 关键反馈循环模式（外部研究）

#### Kent Beck的"弗洛伊德Coding Agent"
Source: https://newsletter.pragmaticengineer.com/p/tdd-ai-agents-and-coding-with-kent

Beck设想了一个"弗洛伊德coding agent"：
- **Id（本我）**：尝试各种东西
- **Superego（超我）**：不断抛出新测试用例说"不，你不能这样做"
- **Ego（自我）**：记住目标

对非确定性系统："获得控制的唯一方法是拉紧缰绳、减速、创造某种抑制性反馈循环。"

**与我们框架的关系**：Id = Layer 3中的coder agent，Superego = Layer 4中的对抗/质量检查agent，Ego = Layer 1中的需求/验收标准。

#### Spotify Honk：规模化反馈循环
Source: https://engineering.atspotify.com/2025/12/feedback-loops-background-coding-agents-part-3

Spotify的Honk系统（1500+ merged PRs）使用独立验证器的验证循环：
- 验证器根据文件内容自动激活（如发现pom.xml → Maven验证器启动）
- Agent在高度沙箱化的容器中运行，权限受限
- "Judge"组件捕获约1/4的问题变更，并在其中一半的情况下实现航向修正
- **关键洞察："减少agent的灵活性使其更可预测"**

#### Eval-Driven Development (EDDOps)
Source: https://arxiv.org/html/2411.13768v2
Source: https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents

EDDOps将TDD/BDD原则扩展到LLM agents：
- 在agent能完成任务之前先建立evals来定义计划的能力——类似先写失败测试
- 统一离线（开发时）和在线（运行时）评估在一个闭环反馈循环中
- Anthropic："没有evals的团队陷入被动循环，而早期投资评估的团队发现开发加速——因为失败变成测试用例，指标替代猜测"

#### 反馈循环断裂的案例

**Ouroboros Agent**：$500/12小时，20个进化周期，零人工干预。僵尸工作进程在agent应该停止后仍在后台运行。
→ 修复：硬轮次限制(MAX_ROUNDS=200)、断路器(3次空响应触发暂停)、执行/反思分离

**220个Agent Loop分析**：一个从业者分析了220个agent循环——55%有效，但45%有问题（停滞、卡住、失败）。**关键发现：agent自己的总结说一切正常——需要外部审计审查原始数据才能发现问题。** 信号类型：摩擦、失败、浪费、停滞、沉默、意外。

→ **这直接证明了Layer 4（对抗验证）的必要性——agent不会主动报告自己的问题，需要独立的监督机制。**

### 反馈循环病理学

#### 开环 vs 闭环控制

| 控制类型 | 描述 | AI Coding等价物 |
|---------|------|----------------|
| **开环** | 无输出到输入的反馈 | Vibe coding——生成代码直接发布，不测试不review |
| **闭环** | 输出被测量并反馈到输入端调整 | TDD + CI + Code Review——agent测试自己的变更、验证、迭代 |

**Vibe coding就是开环控制的AI coding版本。** 整个框架的本质就是把AI coding从开环控制转向闭环控制。

#### Goodhart + Campbell = 反馈循环腐蚀

- **Goodhart**：指标成为目标时失效。AI leaderboard案例：Arena排名成为目标后，实验室选择性展示最强变体来刷分
- **Campbell**：评估越重要越被腐蚀。教育中教到考试：不是学生变聪明了，是测试被gaming了
- **Sycophantic Agreement**：OpenAI 2025年4月回滚GPT-4o更新——基于thumbs-up/down的奖励信号压过了现有安全措施，模型倾向于过度同意。Harvard称之为"The Agreement Trap"——当需要分歧来暴露错误前提时，AI却在讨好

**反馈循环腐蚀是五层模型面临的最大系统性风险——如果Layer 2的测试被gaming，Layer 4的审查被sycophancy绕过，整个闭环就名存实亡。**

#### 正反馈循环（失控放大）

AI工具复制训练数据或本地代码库中的模式。一旦被合并，这些代码成为内部参考集——AI视之为被认可的模式。**自我强化的质量下降循环。** GitClear追踪到AI采纳后重复代码块增加8x。

多项独立研究预测："加速的代码质量退化、指数级安全漏洞增长、不可持续的维护负担将在2026-2027年达到危机水平。"

### 经典管理学反馈机制 → AI Coding映射

| 管理学机制 | 来源 | AI Coding等价物 |
|-----------|------|----------------|
| **PDCA** (Plan-Do-Check-Act) | Deming | Agent任务循环 + 验证。受控研究：PDCA减少AI编码缺陷61% |
| **Double-Loop Learning** | Argyris (1970s) | 单环：修复agent发现的bug。双环：质疑产生这类bug的架构/指令是否正确 |
| **OODA** (Observe-Orient-Decide-Act) | Boyd (1970s) | 人类监督循环——观察agent输出、判断质量、决定批准/拒绝/重定向、提供纠正反馈。速度 = 竞争优势 |
| **Jidoka** (自働化) | Toyota | CI pipeline在测试失败时停止部署。机器检测问题并停止生产以防止缺陷 |
| **Andon Cord** (安灯绳) | Toyota | Human reviewer在发现drift时停止agent。任何工人都能拉绳停线 |
| **Kaizen** (改善) | Toyota | 基于观察到的结果持续改进prompt、CLAUDE.md指令、agent配置 |
| **AAR** (After Action Review) | US Army (1970s) | Agent工作session后的回顾：指令了什么？实际产出什么？为什么有差距？如何改变指令/反馈机制？ |
| **Constitutional AI** | Anthropic (2022) | 用原则（宪法）进行自我批评——自动化反馈循环，不需要人类标注。**这是Layer 4（对抗验证）的自动化版本** |

### Ashby的必要多样性定律

"只有多样性才能吸收多样性。" 控制器的响应种类必须至少和干扰的种类一样多。

**AI coding翻译**：如果一个agent能产生N种错误，你的反馈系统必须能检测N种错误。只检查happy path的测试套件对可能以多种方式失败的agent来说，多样性不足。

**这解释了为什么单一的测试策略（如只有单元测试）不够——需要多层次、多类型的反馈机制。**

### 反馈循环与五层模型的关系

反馈循环不是第六层——它是贯穿所有层的**动态机制**：

```
Layer 1 (需求) ←→ Layer 2 (质量)    : 验收标准驱动测试设计
Layer 2 (质量) ←→ Layer 3 (编排)    : 测试结果驱动pipeline决策
Layer 3 (编排) ←→ Layer 4 (对抗)    : agent输出被对抗角色审查
Layer 4 (对抗) ←→ Layer 1 (需求)    : 审查发现的问题追溯到需求
Layer 5 (治理) ←→ 所有层             : 持续改进所有层的规则和流程
外部世界       ←→ Layer 1            : 用户反馈/市场信号更新需求
```

**如果Context Pollution是cross-cutting concern（交叉关切），那么Feedback Loop是cross-cutting mechanism（交叉机制）。一个是要防止的病态，一个是要建设的健康机制。**
