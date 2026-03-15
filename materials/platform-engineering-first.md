# Platform Engineering First
**Source:** brainstorm.md (2026-03-12), lines 1142-1165

## 核心概念：Platform Engineering First（平台工程前置）

### 在写一行代码之前，先搭建反馈基础设施

传统思维：先写代码 → 再补测试 → 再搭CI/CD → 最后补文档
AI时代思维：**先搭建平台（反馈基础设施）→ 再让agent在平台上工作**

这和Harness Engineering的核心观点一致："工程师的工作从产出正确代码转向产出一个让agent能可靠地产出正确代码的环境。"

**Platform Engineering First意味着：**
1. CI/CD pipeline先于第一行业务代码
2. 测试框架先于第一行实现
3. Lint/format/hooks先于第一次commit
4. 文档结构先于第一个PRD
5. 监控/可观测性先于第一次部署

**没有反馈平台的agent工作 = 没有仪表盘的飞行 = 开环控制。**

### 与Harness Engineering的关系

OpenAI的经验（100万行代码，零人工编写）：工程团队的主要工作变成了"让Agent能做有用的工作"。LangChain实验：只调整harness不改模型，分数从52.8→66.5。

**Platform Engineering First就是Harness Engineering的时序原则——不是"顺便也搭个平台"，而是"平台是第一优先级"。**
