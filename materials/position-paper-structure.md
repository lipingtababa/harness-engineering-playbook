# Position Paper Structure
**Source:** brainstorm.md (2026-03-12), lines 255-341

## Position Paper 结构

### 标题选项

**学术风格：**
1. "Managing AI Agents: A Management Theory Framework for AI-Assisted Software Development Practices"
2. "From Tools to Teammates: Applying Management Science to AI Coding Agent Orchestration"
3. "The Five-Layer Model: A Unified Framework for Emerging AI Coding Practices"

**中文公众号风格：**
1. "AI编程的管理学：当代码不再是人写的，管理才刚刚开始"
2. "五层模型：社区AI编程实践的统一理论框架"
3. "从管人到管Agent：AI编程实践背后的管理学原理"

### 论文/Talk结构

**Abstract / 摘要**
AI coding社区在过去几个月涌现了大量看似零散的实践（TDD复兴、skills架构、角色对抗、政委模式、文档分层...）。本文提出一个五层模型(Five-Layer Model)来统一解释这些实践，论证AI编程本质上是一个管理学问题而非工具问题。我们将管理学、控制论和分布式系统理论映射到这些实践，并识别出社区尚未解决的关键问题。

**1. Introduction / 引言**
- 问题：社区实践的碎片化——每个人都在发明自己的方法，缺乏理论统一
- 观察：这些实践有惊人的相似性，指向共同的底层原理
- 命题：AI编程 = 管理不可靠但能力强的"员工"
- 贡献：五层模型 + 理论映射

**2. Background / 背景**
- AI coding工具的现状（Claude Code, Cursor, Copilot, Windsurf...）
- 社区实践的涌现（WeChat群、Twitter、GitHub、博客）
- 现有框架的不足（BMAD太具体、Agile太笼统、DevOps不够）

**3. The Five-Layer Model / 五层模型**
- Layer 1: Specification & Contract (需求与契约)
- Layer 2: Quality Control (质量控制)
- Layer 3: Pipeline & Orchestration (流水线与编排)
- Layer 4: Adversarial & Verification (对抗与验证)
- Layer 5: Governance & Evolution (治理与演进)

**4. Theoretical Foundations / 理论基础**
- 4.1 管理学映射
- 4.2 控制论映射
- 4.3 分布式系统映射

**5. Case Studies / 案例研究**
- 5.1 我自己的实践：conduct skill, tester/coder分离, quality checker
- 5.2 社区案例：BMAD框架、Ouroboros agent、跨模型验证
- 5.3 工业案例：Meta JiTTest、Kent Beck的AI+TDD

**6. Open Problems / 开放问题**
- 谁来监督监督者？(递归验证问题)
- AI欺骗的对策是否会被AI学会绕过？
- 自动化评估的Goodhart风险
- 何时human in the loop，何时可以放手？
- context window增大是否会让部分实践过时？

**7. Discussion / 讨论**
- 管理学理论的适用边界：哪些原理完美迁移，哪些需要修改
- 从管理人到管理AI：本质差异在哪里？
- AI coding是软件工程的子领域还是管理学的子领域？

**8. Conclusion / 结论**
- 社区实践不是随机的，是对共同问题的独立发现
- 五层模型提供了一个组织和理解这些实践的框架
- 下一步：从描述性框架走向规范性框架

---

## 潜在发表渠道

### 学术会议
- **ICSE** (International Conference on Software Engineering) — 顶会，接受industry track
- **ESEC/FSE** (ACM Joint European Software Engineering Conference) — 接受vision papers
- **ASE** (Automated Software Engineering) — 与AI相关
- **CHASE** (Cooperative and Human Aspects of Software Engineering) — 人因方面
- **XP Conference** (International Conference on Agile Software Development) — 更实践导向
- **IEEE Software** — 期刊，接受practitioner-oriented papers

### Industry Talk
- **QCon** — 实践导向，中英文都有
- **Strange Loop** — 前沿技术
- **GOTO Conference** — 软件工程社区
- **InfoQ** — 文章/演讲
- **ThoughtWorks Technology Radar** — 如果框架被采纳

### 中文渠道
- **公众号系列文章** — 先用中文验证想法
- **极客时间** — 专栏/课程
- **InfoQ中文站** — 技术文章
