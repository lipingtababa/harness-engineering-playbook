# Harness Engineering：驾驭 AI Coding Agent 的工程学

> 基于 OpenAI、Anthropic、Martin Fowler 和学术研究的综合整理

---

## 一、定义

**Harness Engineering（驾驭工程）** = 设计环境、约束和反馈回路，使 AI coding agent 在规模化场景下可靠工作的工程学科。

**词源**："Harness"来自马具（缰绳、马鞍、马嚼）—— 一整套用于引导强大但不可预测的动物朝正确方向前进的装备。

**核心转变**：
- 从期待 AI 无限灵活 → 转向构建结构化、可维护的 AI 生成系统
- 从专注模型能力 → 转向设计让 AI 能够可靠工作的系统

---

## 二、为什么需要 Harness Engineering？

### OpenAI 的实践（2025-2026）

**实验设定**：
- 强制规则："不允许人工手写任何代码"
- 持续 5 个月
- 结果：构建了一个真实产品，超过 **100 万行代码**

**核心发现**：
工程团队的主要工作变成了 **"让 Agent 能做有用的工作"**，而不是自己写代码。

### LangChain 的验证

在 Terminal Bench 2.0 测试中：
- **只调整 harness，不改模型**
- 分数从 52.8 → 66.5（提升 13.7 分）

**结论**：Harness 设计的影响力可能超过底层模型本身。

### Martin Fowler 的观察

5 个月的开发周期揭示：这需要大量工程投资 —— 不只是规则文档，而是**广泛的确定性工具和深思熟虑的代码设计**。

---

## 三、Harness Engineering 的三大支柱

### 1. Context Engineering（上下文工程）

**核心原则**：
> "从 Agent 的视角看，任何无法在运行时访问的信息，实际上不存在。"

**问题**：
- Google Docs 里的知识？不存在
- 聊天记录里的讨论？不存在
- 人们脑子里的经验？不存在

**解决方案**：
- **Repository-local artifacts**：代码、markdown、schema、可执行计划 —— 版本化、本地化
- **持续增强的知识库**：嵌入代码库中
- **动态上下文访问**：包括可观测性数据、浏览器导航
- **Code as context**：大量设计工作让代码本身成为上下文

**具体技术**：
- 文档驱动开发（所有知识都文档化在 repo 中）
- 结构化 schema（JSON、YAML）描述系统状态
- 可执行计划（不是自然语言描述，而是可执行的步骤）

### 2. Architectural Constraints（架构约束）

**核心原则**：
用机械化的、可自动检查的规则，保持代码库对未来 Agent 运行的可读性和一致性。

**OpenAI 的"Golden Principles"**：
- 固执己见的（opinionated）
- 机械化的（mechanical）
- 可自动检查的（automatically checkable）

**监控手段**：
1. **LLM-based agents**：用 AI 检查 AI
2. **Deterministic custom linters**：自定义的确定性 lint 工具
3. **Structural tests**：强制边界（例如用 ArchUnit）
4. **Pre-commit hooks**：提交前自动检查
5. **Data structure stability enforcement**：模块边界的数据结构稳定性强制

**具体实践**：
- 架构模式强制执行
- 模块边界清晰定义
- 接口契约（API contracts）
- 目录结构规范

### 3. Entropy Management（熵管理 / 垃圾回收）

**核心问题**：
AI 生成的代码会不断产生"AI slop"（AI 垃圾） —— 不一致、冗余、腐化的代码。

**OpenAI 的痛点**：
团队曾经每周五（20% 时间）都在清理 AI 生成的垃圾代码。

**解决方案**：
1. **周期性 Agent 运行**：
   - 检测文档中的不一致
   - 识别架构约束违规
   - 发现代码腐化

2. **自动化清理流程**：
   - 定期运行清理 Agent
   - 识别并修复不一致
   - 删除冗余代码

3. **持续对抗代码腐化**：
   - 不是一次性清理
   - 而是持续的、自动化的过程

---

## 四、Anthropic 的长期运行 Agent Harness 设计

### 核心挑战

Agent 如何在多个 context window 之间有效工作？（每次对话都有 token 限制）

### 两阶段解决方案

#### 阶段 1：Initializer Agent（初始化 Agent）

**第一个 session 的任务**：
1. 创建 `init.sh` 脚本（运行开发环境）
2. 生成 `claude-progress.txt` 文件（记录已完成的工作）
3. 建立初始 git commits（显示添加了哪些文件）

#### 阶段 2：Coding Agent（编码 Agent）

**后续 sessions 的结构化实践**：

1. **Feature-Based Work（基于功能列表的工作）**：
   - 建立结构化 JSON 文件
   - 列出端到端的功能描述
   - 一次只做一个功能（而非试图同时做所有事）

2. **Incremental Progress（增量进展）**：
   - 防止 context 耗尽
   - 避免不完整的实现

3. **Clean State Maintenance（清洁状态维护）**：
   - 每个 session 结束时：git commit + 更新 progress 文档
   - 允许 Agent 回滚有问题的更改
   - 理解之前的工作内容

4. **Rigorous Testing（严格测试）**：
   - 端到端验证（使用浏览器自动化工具）
   - 不只是单元测试
   - 捕获真实世界的 bug

### 关键设计模式

**"如何让 Agent 在新的 context window 中快速理解工作状态"**

解决方案：
- Progress 文件 + git history
- 模仿人类工程团队的工作方式

---

## 五、OPENDEV 的学术研究发现

### 核心技术

#### 1. Adaptive Context Compaction（自适应上下文压缩）
- 渐进式减少旧观察
- 防止 context 膨胀
- 避免推理退化

#### 2. Dual-Agent Architecture（双 Agent 架构）
- **Planning Agent**：负责规划
- **Execution Agent**：负责执行
- 分离关注点，提高效率

#### 3. Workload-Specialized Model Routing（工作负载专门化模型路由）
- 不同 AI 组件处理不同职责
- 提高效率

#### 4. Lazy Tool Discovery（惰性工具发现）
- 不预先加载所有工具
- 需要时才识别可用工具

#### 5. Automated Memory System（自动化记忆系统）
- 跨 session 积累项目特定知识
- 通过事件驱动的系统提醒解决"指令淡出"问题

### 关键教训

**"有效的自主协助需要严格的安全控制和高效的上下文管理"**

---

## 六、Harness Engineering 的迭代反馈循环

Martin Fowler 强调的核心流程：

```
Agent 遇到困难
  → 把它当作信号
  → 识别缺少什么（工具、护栏、文档）
  → 把解决方案反馈到 repository 中
  → 下次 Agent 就能更好地工作
```

这是一个 **持续改进** 的过程，而非一次性设计。

---

## 七、与原始 AI Coding Framework 的对应

| AI Coding Framework | Harness Engineering 对应 |
|-------------------|------------------------|
| **文档驱动** | Context Engineering - Repository-local artifacts |
| **测试先行** | Rigorous Testing + Structural tests |
| **角色对抗** | Dual-Agent Architecture + LLM-based monitoring |
| **Skill 体系** | Automated Memory System + Feature-Based Work |
| **质量控制** | Entropy Management + Architectural Constraints |
| **信任边界** | Pre-commit hooks + Deterministic linters |
| **组织落地** | Golden Principles + Continuous cleanup |

---

## 八、Harness Engineering 的完整清单

基于所有来源，一个完整的 Harness 应该包括：

### 1. 知识管理
- [ ] Repository-local 文档（不依赖外部知识）
- [ ] 可执行计划（非自然语言描述）
- [ ] 结构化 schema（JSON/YAML）
- [ ] Progress tracking 文件
- [ ] Git history as knowledge base

### 2. 架构约束
- [ ] Golden Principles（机械化规则）
- [ ] Custom linters（定制化检查）
- [ ] Structural tests（架构边界强制）
- [ ] Pre-commit hooks
- [ ] API contracts（接口契约）
- [ ] Module boundary enforcement

### 3. 质量保障
- [ ] 端到端测试（自动化）
- [ ] 回归测试
- [ ] 文档一致性检查
- [ ] 周期性清理 Agent
- [ ] 自动化垃圾回收

### 4. 上下文管理
- [ ] Adaptive context compaction
- [ ] Feature-based work splitting
- [ ] Incremental progress tracking
- [ ] Clean state maintenance
- [ ] Cross-session memory system

### 5. 安全与隔离
- [ ] 沙箱环境
- [ ] 权限隔离
- [ ] 回滚机制
- [ ] Lazy tool discovery（按需加载）
- [ ] Deterministic validation

### 6. 可观测性
- [ ] Browser navigation 可观测
- [ ] 系统状态可见
- [ ] 错误追踪
- [ ] Performance monitoring
- [ ] Agent 行为日志

### 7. 迭代机制
- [ ] Agent 遇到困难的信号捕获
- [ ] 问题根因分析
- [ ] 解决方案反馈到 repo
- [ ] 持续优化循环

---

## 九、关键洞察

### 1. Harness > Model
LangChain 的实验证明：优化 harness 可能比更换更强模型更有效。

### 2. 工程投资巨大
OpenAI 5 个月、Martin Fowler 强调"substantial engineering investment" —— 这不是写几个文档就能完成的。

### 3. 持续对抗熵
代码腐化是持续的，必须建立自动化机制持续对抗。

### 4. Context is Everything
从 Agent 视角看，只有 in-context 的信息才存在。

### 5. 安全不可妥协
学术研究强调"strict safety controls" —— 无人值守执行必须有安全保障。

### 6. 模仿人类团队
Anthropic 的设计模仿人类工程团队：progress file + git history + feature list。

### 7. 分离关注点
Planning vs Execution，不同职责用不同 Agent/Model。

---

## 十、实践建议

### 对个人开发者
1. 从 progress 文件和 feature list 开始
2. 建立 pre-commit hooks
3. 写测试，不要只依赖 AI 生成的代码能跑

### 对团队
1. 制定 Golden Principles（机械化规则）
2. 建立自动化 lint 和测试流程
3. 投资 context engineering（文档化所有知识）
4. 建立周期性清理机制

### 对组织
1. 认识到这是大的工程投资（不是买工具就能解决）
2. 建立专门的 Harness Engineering 团队
3. 持续优化迭代反馈循环
4. 建立 Skill/Knowledge 共享机制

---

## 十一、参考资源

- **OpenAI Harness Engineering**：https://openai.com/index/harness-engineering/
- **Martin Fowler 文章**：https://martinfowler.com/articles/exploring-gen-ai/harness-engineering.html
- **Anthropic Long-Running Agents**：https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- **OPENDEV 论文**：https://arxiv.org/abs/2603.05344
- **Phodal Routa 实现**：https://github.com/phodal/routa
- **LangChain 实践**：https://blog.langchain.com/improving-deep-agents-with-harness-engineering/

---

## 总结

Harness Engineering 不是可选项，而是 AI Coding 在规模化、产品化场景下的 **必需品**。

它不是关于"如何让 AI 写更好的代码"，而是关于 **"如何建立一个让 AI 能够持续、可靠、安全地写代码的系统"**。

这是从个人 10x 提效到组织级 AI Coding 的关键桥梁。
