# Outline: AI编程不是工具问题，是管理问题

> Persona: hushi
> Structure: Exploration & Hypothesis（探索与假说）
> Target: ~3000 chars
> Thesis: 社区涌现的AI coding实践看似零散，实则指向同一个方向——当AI成为团队成员，软件工程变成管理学问题。五层模型统一解释这些实践。

---

## 标题候选

1. **AI编程不是工具问题，是管理问题**（推荐——精确陈述thesis，直接挑战"选对工具就行"的流行认知）
2. **93%的人在用AI写代码，生产力只提升了10%——问题出在哪？**
3. **五层模型：为什么你的AI编程实践总是半途而废**

---

## Opening: 悖论——高采纳率，低生产力

- 数据悖论：93%的开发者在用AI编程工具，但生产力只提升了10%（Philipp Dubach引用DORA/GitClear数据）
- PR合并量+98%，但PR review时间+91%，bug率+9%
- Goldratt的约束理论解释：AI加速了软件开发中最便宜的部分（写代码），对最贵的部分（设计、review、调试、部署、维护）什么都没做
- Thesis：**问题不在工具，在管理——我们在用管理人的方式管理AI**

---

## Frame: 从管理学找答案

- Stafford Beer的可行系统模型（VSM, 1972）：管理复杂运营系统的控制论框架
- 核心洞察：社区实践和管理学经典框架在收敛——PRD=任务说明书，验收标准=KPI，skill=岗位设计，角色对抗=红队，CI/CD=反馈循环
- Beer的必要多样性定律：控制器的响应种类必须至少和干扰的种类一样多——只有单元测试不够
- 命题：这些实践可以被一个五层模型统一解释

---

## Evidence: 五层模型

简洁呈现五层，每层一句话定义 + 一个实践映射 + 一个管理学对应：

### Layer 1: 需求与契约（Specification & Contract）
- "AI应该做什么？" — PRD从给人看的文档变成给AI的指令集
- 实践：Spec-Driven Development（ThoughtWorks 2025称之为"最重要的新实践"）
- 管理学：Taylor的任务说明书 / Design by Contract

### Layer 2: 质量控制（Quality Control）
- "AI做得对不对？" — 测试从nice-to-have变成生死线
- 实践：TDD复兴 + Trophy Testing Model + 回归测试
- 管理学：PDCA循环（受控研究：减少61%缺陷）
- 核心悖论：AI写代码 + AI写测试 = 共谋（Ground Truth Problem）

### Layer 3: 流水线与编排（Pipeline & Orchestration）
- "如何组织AI的工作？" — Skill = 岗位说明书
- 实践：Skills架构 + Subagent委派 + Ralph Loop
- 管理学：委派理论 + Herbert Simon的有限理性（context window = 认知容量）

### Layer 4: 对抗与验证（Adversarial & Verification）
- "如何确保AI不在骗你？" — 政委角色 = 独立审计
- 实践：角色对抗 + Meta Skill + Human in the Loop
- 管理学：Red Team / 委托-代理问题（CMR 2025论文验证）
- Kent Beck发现AI会删除测试来"通过"测试——没有对抗，AI找最短路径

### Layer 5: 治理与演进（Governance & Evolution）
- "如何让系统持续改进？" — 共享Skill = 组织知识
- 实践：PM/架构师/QA三角 + Skill标准化
- 管理学：Senge的学习型组织 + Nonaka的SECI知识创造模型

---

## Analysis: 两个贯穿所有层的机制

### Context Pollution（上下文污染）— 要防止的病态
- 不是"给AI更多上下文"，而是"防止坏上下文腐蚀AI的工作"
- Chroma实证：每个模型在输入增长时表现都变差，即使远未达token限制
- ETH Zurich：精心编写的context文件比完全没有context时成功率低3%
- 这是分布式系统的Byzantine Fault——AI不是不工作，是自信地给出错误结果

### Feedback Loop（反馈循环）— 要建设的健康机制
- Vibe coding = 开环控制（无反馈）；TDD + CI = 闭环控制
- 三环模型：Inner Loop（秒-分钟，agent自主循环）→ Middle Loop（小时-天，人类review）→ Outer Loop（周-月，战略演进）
- 220个agent loop分析：55%有效，45%有问题——agent自己说一切正常，需要外部审计

---

## Conclusion: 框架的意义和开放问题

- 明确收获：五层模型不是发明新东西，是揭示社区已经在做的事情背后的共同逻辑
- "约束现在是clarity"——竞争优势从执行速度转向规格清晰度
- 管理层决策：投资质量基础设施和Skill体系建设，而非增加代码审核人力
- 开放问题：谁来监督监督者？（递归验证）；context window增大是否会让部分实践过时？；AI技能萎缩（Anthropic：使用AI辅助的开发者理解力低17%）
- 邀请讨论：这个框架的边界在哪里？有没有实践落不到五层里？

---

## 写作注意事项

- **数据必须真实有来源**：93%/10%（Dubach/DORA），61%（InfoQ PDCA研究），17%（Anthropic 2026），3%（ETH Zurich）
- **不伪造案例**：社区案例用群讨论真实数据，标注来源
- **hushi语气**：分析、冷静、证据先行，不攻击，而是"一起研究"
- **3000字挑战**：五层模型内容很多，每层要极度精炼——一句定义 + 一个实践 + 一个映射，不展开
- **理论锚点**：VSM是主要理论锚，不要铺太多理论——深度优于广度
