# Theory Mapping Tables
**Source:** brainstorm.md (2026-03-12), lines 196-253

## 理论映射总览

### 管理学映射

| AI Coding实践 | 管理学概念 | 经典来源 |
|---------------|-----------|----------|
| PRD / 需求文档 | 任务说明书 (Job Description) | Scientific Management (Taylor) |
| 验收标准 | KPI / OKR | Drucker, Grove |
| Skill Layout | 组织架构 / 岗位设计 | 组织理论 |
| Subagent委派 | 委派理论 | Management by Delegation |
| 角色对抗 | Red Team | 军事情报 |
| 政委角色 | 内审 / 审计委员会 | 公司治理 |
| 批评与自我批评 | Retrospective / After Action Review | 敏捷 / 军事 |
| Human in the Loop | 管理层审批 | 审批流程 |
| 5 Whys | 根因分析 | Toyota Production System |
| 共享Skill | 知识管理 | Nonaka & Takeuchi |
| PM/架构师/QA三角 | 三权分立 / 制衡 | 组织治理 |
| Dangerous Compaction | 有限理性 | Herbert Simon |

### 控制论映射

| AI Coding实践 | 控制论概念 |
|---------------|-----------|
| PRD → 代码 → 测试 | 闭环控制 (Closed-loop control) |
| CLAUDE.md without hooks | 开环控制 (Open-loop control) |
| CI/CD pipeline | 反馈循环 (Feedback loop) |
| 回归测试 | 误差修正 (Error correction) |
| 角色对抗 | 负反馈 (Negative feedback) |
| Dangerous Compaction | 信息损失 (Information loss) |
| Human in the Loop | 人工干预 (Manual override) |

### 分布式系统映射

| AI Coding实践 | 分布式系统概念 |
|---------------|---------------|
| 文档一致性 | 分布式共识 (Distributed consensus) |
| PRD as SSOT | 单一信源 (Single Source of Truth) |
| API契约 | 接口契约 (Interface contract) |
| Subagent通信 | 消息传递 (Message passing) |
| Context window限制 | 网络分区 (Network partition) |
| 最终一致性 | Eventual consistency |

---

## 已有文章与本框架的关系

| 已有文章/研究 | 覆盖的Layer | 已发表？ |
|--------------|------------|---------|
| hushi/ai-coding-consistency | Layer 1 (文档一致性) | 起草中 |
| benyu/ai-coding-consistency | Layer 1 (宪法隐喻批判) | 起草中 |
| hushi/testing-with-ai | Layer 2 (测试范式) | 起草中 |
| root brainstorm (评估是进化的前提) | Layer 2 + Layer 4 (评估理论) | 素材 |
| benyu/ai-testing-paradigm | Layer 2 (TDD经济学) | ? |
| hushi/civil-engineering-quality-control | Layer 2 (质量控制) | ? |
| hushi/e2e-testing | Layer 2 (端到端测试) | ? |
| debate-thoughtworks | Layer 4 (TDD原教旨主义批判) | 素材 |
