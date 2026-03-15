# AI Coding 中的文档分类与分层

> 基于马工社区讨论和实践的文档体系整理

---

## 一、核心洞察：文档从 UI 到状态机

### Jun 的框架（2026-02-10）

**过去（人类协作时代）**：
- 人是主系统
- 文档是 UI（界面）
- 文档的作用：提供容错层（因为人理解慢、记忆有限、有情绪）
- 文档目的：表达、理解、对齐

**现在（AI 协作时代）**：
- **文档从 UI 变为状态机**
- 人成为节点、异常处理器
- 文档目的：驱动自动化工作流
- 状态信息是支持过程的最有效信息

### 陈浩的延伸

**过去写的那么多邮件、文档、会议纪要是给谁看的？**
→ 这个人在 AI 时代还在吗？

**答案**：
- 人和人的协作会简化
- 人和 AI 的协作增加了很多
- **要输出面向 AI 的文档**

---

## 二、胥克谦的 4 环节文档体系

### 概述（2026-01-22）

**核心特点**：
- 4 环节，1234 分别是一套文档
- "这个 4 环节文档过程，基本很难压缩了"（已经过优化）
- 每个 skill 都有 3000+ 行
- "光靠提示词，肯定做不到质量可控的"

**核心难点**：
- 环节 1 是最核心的，"是真正过去最难的部分"
- 文档质量
- "开会的逻辑"

**工作方式**：
- "这些都做到位了，开发就是等待"
- "问题修复也基本是等待"
- 整个开发是 10，有 8 是在文档上（王欢.ai）

### 4 环节的具体内容

虽然胥克谦没有公开完整细节，但从上下文可以推断：

**环节 1：需求与架构文档**
- PRD（产品需求文档）
- 架构文档
- 这是最核心、最难的部分

**环节 2：设计文档**
- 详细设计
- 模块拆分

**环节 3：开发计划**
- 二级 task 机制
- 主动拆解的分阶段开发计划文档
- 进一步自动拆解到原子级

**环节 4：执行与验证**
- 测试文档
- 验收标准

### 版本管理机制（GPT 的实践）

**两个 change log 文件**：
- `prd-change-log.md` — 记录改动需求
- `dev-change-log.md` — 记录改动行为和结果

**胥克谦的回应**："这个非常赞"

**重要原则**：
- "如果存在半成品文档，跟程序不一致了，很麻烦的"
- "要专门花时间维护的"
- 阶段性要保证完整性

---

## 三、Ethan 的 3 步 Spec Pipeline

### 核心观点（2026-02-13）

**步骤压缩的趋势**：
- 过去：5 步、4 步（模型能力不行，只能靠指令）
- 现在：3 步（requirements → design → verification）
- 未来：可能更少（"6 个月后，等模型能力上来，可能还是要变，用不了这么啰嗦"）

**为什么压缩？**
- leo：5 件套每步都会修改出一些偏离的方向来，最后越走越偏
- 累积漂移（cumulative drift）会复合
- 强模型需要更少的交接

### 3 步的具体内容

**Step 1: Requirements（需求）**
- User story
- Ethan："我看两头，user story 弄对了没有... 这个我觉得多数人没有搞清楚"

**Step 2: Design（设计）**
- Exec_spec（执行规格）
- 可以有多个，类似敏捷里的 vertical slice
- 自说明的（self-contained）
- 核心内容：目标、验收、各种技术围栏

**Step 3: Verification（验证）**
- Test assets（测试资产）
- Ethan："后面看 test asset"
- TDD 驱动推进

### 声明式 vs 指令式

**Ethan 的观点**：
- 声明式（declarative）能让模型发挥更好
- 指令式（imperative）反而约束了模型，可能无所适从

**马工的反驳**：
- LLM 的 session 生命周期都很短，一致性很差
- 如果不给 guideline，每次都随意发挥
  - 今天用 `go test`
  - 明天用 `make test`
  - 后天跑 `run_test.sh`
- 项目大了之后，结构就乱了，项目也不会积累 knowhow

**马工的平衡观点**：
- **Verification 是终极指标，但指令也很重要**
- 类比：你可以把工作全面委托给下属，自己只看指标。但有时候手把手的指导，或者同步，也是很有价值的

### 过程管理 vs 结果管理（leo）

**两者都不可缺**：
- 规矩（过程管理）
- 验收（结果管理）

**过程是以更快、更省的方式拿到结果**

**马工补充**：
- 过程不管理的话，很容易把 LLM 埋到坑里爬不出来
- 然后它逼急了，就会乱改你的测试用例，糊弄你说任务完成了（和人一样）
- 你不管理过程的话，怎么知道任务拆分的颗粒度合适呢？
  - 也许太粗了，以至于 LLM 完不成
  - 也许太细了，以至于集成不起来

---

## 四、文档分类框架（综合整理）

基于以上讨论，我们可以提出一个文档分类框架：

### 按层次分类

#### Layer 1: 战略文档（给人看的）
**目的**：定义方向、对齐理解
- Product Vision
- Roadmap
- Business Requirements

**特点**：
- 人类可读性优先
- 解释型信息
- 容错层（应对人的理解慢、记忆有限）

#### Layer 2: 状态机文档（给 AI 执行的）
**目的**：驱动自动化工作流
- PRD（结构化）
- Architecture Docs
- API Contracts
- Acceptance Criteria

**特点**：
- 机器可解析性优先
- 状态信息
- 可执行的

#### Layer 3: 过程控制文档（约束 AI 行为的）
**目的**：保证一致性、积累 knowhow
- Development Plan（二级 task）
- Technical Guidelines（技术围栏）
- Coding Standards
- Test Strategy

**特点**：
- 指令式 + 声明式混合
- 定义边界和约束
- 可积累、可迭代

#### Layer 4: 验证文档（证明正确性的）
**目的**：自动化质量保障
- Test Specs
- Test Assets
- Acceptance Test Cases
- Mock Server Specs

**特点**：
- 可执行的
- 自动化的
- 作为终极指标

#### Layer 5: 追踪文档（记录状态和历史的）
**目的**：跨 session 记忆、可回溯
- Progress Tracking（claude-progress.txt）
- Change Logs（prd-change-log.md, dev-change-log.md）
- Decision Records（ADR）
- Git History

**特点**：
- 状态信息
- 时间序列
- 可回溯

### 按用途分类

#### 1. 约束类文档
**作用**：防止 AI 乱发挥
- Golden Principles
- Coding Standards
- Architecture Constraints
- Technical Guidelines

**对应 Harness Engineering**：Architectural Constraints

#### 2. 上下文类文档
**作用**：让 AI 知道项目状态
- Architecture Docs
- API Contracts
- Decision Records
- Progress Tracking

**对应 Harness Engineering**：Context Engineering

#### 3. 验证类文档
**作用**：自动质量保障
- Test Specs
- Acceptance Criteria
- Mock Server Specs
- Benchmark Definitions

**对应 Harness Engineering**：Entropy Management

#### 4. 执行类文档
**作用**：驱动 AI 工作
- PRD
- User Stories
- Development Plan
- Exec Spec

**对应 Harness Engineering**：Context Engineering

---

## 五、文档分级（按重要性和访问频率）

### P0：核心执行文档
**必须存在，AI 每次都读**
- User Story
- Acceptance Criteria
- API Contracts
- Test Specs

### P1：约束和指导文档
**必须存在，AI 定期读**
- Architecture Docs
- Coding Standards
- Technical Guidelines
- Progress Tracking

### P2：背景和历史文档
**可选，AI 按需读**
- Decision Records
- Change Logs
- Architecture Decision Records
- Design Rationale

### P3：人类对齐文档
**给人看的，AI 不需要**
- Meeting Notes
- Email Threads
- Presentation Slides
- Brainstorming Docs

---

## 六、与 Harness Engineering 的对应关系

| 文档类型 | Harness Engineering | 作用 |
|---------|-------------------|------|
| 约束类文档 | Architectural Constraints | 防止 AI 乱发挥 |
| 上下文类文档 | Context Engineering | In-repo knowledge |
| 验证类文档 | Entropy Management | 自动质量保障 |
| 追踪类文档 | Context Engineering | 跨 session 记忆 |
| 执行类文档 | Context Engineering | 驱动 AI 工作 |

---

## 七、最佳实践

### 1. 文档即状态机
- 不要写给人看的解释性文档
- 写可执行的、结构化的文档
- 状态信息 > 解释型信息

### 2. 版本化管理
- 所有文档都 in-repo
- 用 Git 管理版本
- Change logs 记录修改原因

### 3. 一致性维护
- 避免半成品文档
- 阶段性保证完整性
- 文档与代码必须同步

### 4. 分层访问
- P0 文档：每次执行都读
- P1 文档：定期读取
- P2 文档：按需读取
- P3 文档：不给 AI

### 5. 过程 + 结果双管齐下
- 不能只有验收标准（结果管理）
- 也需要技术围栏和指导（过程管理）
- 平衡声明式和指令式

### 6. 持续压缩步骤
- 模型能力提升 → 步骤可以减少
- 避免累积漂移
- 但不能完全没有约束

---

## 八、反面案例

### ❌ 错误做法

**1. 文档散落各处**
- Google Docs 里的需求
- Slack 里的决策
- 会议纪要在 Notion
- AI 无法访问

**2. 只有人类可读的文档**
- 大段自然语言描述
- 没有结构化信息
- AI 无法解析

**3. 只有验收标准，没有过程指导**
- LLM 每次随意发挥
- 技术栈不一致
- 项目不积累 knowhow

**4. 文档与代码不同步**
- 半成品文档
- 修改后忘记更新文档
- 文档变成噪音

### ✓ 正确做法

**1. In-repo + 结构化**
- 所有关键信息都在 repo
- 用 JSON/YAML/Markdown 结构化
- AI 可以直接读取

**2. 文档即状态机**
- 可执行的规格
- 状态信息清晰
- 驱动自动化工作流

**3. 过程 + 结果双管齐下**
- 技术围栏（过程管理）
- 验收标准（结果管理）
- 两者结合

**4. 版本化 + Change logs**
- Git 管理所有文档
- Change logs 记录修改
- 可回溯、可审计

---

## 九、总结

### 核心转变

**从**：文档 = 人类协作的 UI
**到**：文档 = AI 工作流的状态机

### 关键原则

1. **In-repo knowledge**：所有知识必须在 repo 中
2. **状态信息 > 解释信息**：机器可解析性优先
3. **分层管理**：P0/P1/P2/P3 按重要性分级
4. **过程 + 结果**：既要验收标准，也要技术围栏
5. **持续压缩**：模型能力提升，步骤可减少
6. **版本化管理**：Git + Change logs

### 实践路径

**个人开发者**：
1. 从 Progress tracking 和 User story 开始
2. 建立 Acceptance criteria
3. 逐步补充 Architecture docs 和 Guidelines

**团队**：
1. 制定文档分类和分层标准
2. 建立 Change logs 机制
3. 定期审查文档与代码一致性
4. 持续优化文档结构

**组织**：
1. 建立文档模板和标准
2. 投资文档基础设施
3. 培训团队"面向 AI 写文档"
4. 建立文档质量度量体系

---

## 十、未解问题

1. **文档膨胀问题**：项目大了，文档很多，如何有效索引？
2. **多作者一致性**：多人写文档，如何保证一致性？
3. **文档测试**：如何测试文档的正确性和有效性？
4. **文档重构**：代码可以重构，文档如何重构？
5. **文档债务**：如何识别和清理过时文档？
6. **最佳颗粒度**：文档应该多细？太粗 LLM 完不成，太细集成不起来
7. **文档即代码**：文档和代码的边界在哪里？(JSON schema, OpenAPI spec, etc.)
