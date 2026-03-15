# 文档信任环分级体系（Ring 0-3）

> 薇冷 Violet 提出的上下文置信度体系，借鉴操作系统安全环模型

---

## 一、核心概念

### 问题

当 LLM 的上下文中同时包含：
- System prompts
- User instructions
- PRD 文档
- Architecture docs
- 互联网搜索结果

**哪个优先级更高？发生冲突时听谁的？**

### 解决方案：Trust Ring 模型

借鉴操作系统的 Ring 0-3 安全模型，定义文档的权威性层级。

---

## 二、Ring 0：宪章级（Constitutional）

### 定义
**无论如何也都要遵守的铁律**

### 特点
- 最高权威性
- 不可违背
- 不可协商
- LLM "最尊重"的层级（Ethan：模型说叫"宪章"它最尊重）

### 内容类型
- **Core Principles**（核心原则）
- **Security Constraints**（安全约束）
- **Non-negotiable Rules**（不可协商的规则）
- **Legal/Compliance Requirements**（法律/合规要求）
- **Golden Principles**（黄金法则）

### 实际例子

```markdown
# Ring 0: Constitutional Rules

## Security
- Never commit credentials to git
- Never use `sudo` in automation scripts
- All database queries must use prepared statements
- Never expose user PII in logs

## Code Quality
- Never commit to main directly
- All code must pass `make test` before commit
- No code without tests (TDD mandatory)

## Standards
- British spelling in all documentation
- camelCase for JavaScript, snake_case for Python
- Never skip git hooks (--no-verify forbidden)

## Legal
- All user data must be GDPR compliant
- No GPL-licensed dependencies in commercial products
```

### 对应关系
- **Harness Engineering**: Golden Principles
- **AI Coding Framework**: 质量控制三大支柱的基础约束

---

## 三、Ring 1：用户意图级（User Intent）

### 定义
**用户最重要的真正目标和意图，必须全面理解、领会和深入贯彻落实用户的精神意图**

### 特点
- 当前任务的核心目标
- 优先级仅次于 Ring 0
- 需要深度理解，而非机械执行
- 体现业务价值和用户需求

### 内容类型
- **User Story**（用户故事）
- **Acceptance Criteria**（验收标准）
- **Business Requirements**（业务需求）
- **Problem to Solve**（要解决的问题）
- **Success Metrics**（成功指标）

### 实际例子

```markdown
# Ring 1: User Intent

## User Story
As a mobile app user, I need to access my account when offline, so that I can view my transaction history even without internet connection.

## Acceptance Criteria
- Transaction history from last 30 days cached locally
- Read-only access in offline mode
- Sync when connection restored
- Clear visual indicator of offline mode

## Success Metrics
- 95% of users can access history within 2 seconds offline
- Zero data loss during offline-online transitions

## Business Value
- Reduce customer support calls by 30%
- Improve user retention by 15%
```

### 对应关系
- **Harness Engineering**: Context Engineering (执行类文档)
- **AI Coding Framework**: 文档驱动的核心
- **PTO 框架**: Product Owner 的输出

---

## 四、Ring 2：规范与记忆级（Documentation & Memory）

### 定义
**文本文件、记忆、架构文档之类的，也包括当前对话。LLM 要自主思考，自己判断**

### 特点
- 常态化文档
- AI 可以基于情况灵活应用
- 需要 LLM 自主判断是否适用当前场景
- 可能随项目演进而变化

### 内容类型
- **Architecture Docs**（架构文档）
- **API Contracts**（API 契约）
- **Coding Standards**（编码规范）
- **Technical Guidelines**（技术指南）
- **Progress Tracking**（进度追踪）
- **Current Conversation History**（当前对话历史）
- **CLAUDE.md** (system auto-loaded buffer)
- **Design Rationale**（设计理由）

### 实际例子

```markdown
# Ring 2: Documentation & Memory

## Architecture Guidelines
- We prefer PostgreSQL for relational data
- Redis for caching and session storage
- Microservices communicate via gRPC
- Frontend uses React + TypeScript

## API Standards
- REST APIs follow JSON:API specification
- Use HTTP status codes correctly
- Pagination via `page[number]` and `page[size]`
- Include `meta` object in all responses

## Code Style
- Use camelCase for JavaScript variables
- Max line length: 100 characters
- Prefer async/await over promises
- Document public APIs with JSDoc

## Project Memory
- Previous session: completed user login feature
- Known issue: password reset email sometimes delayed
- Tech debt: refactor auth middleware before v2.0
```

### 薇冷 Violet 的特殊观点

**CLAUDE.md 的定位**：
- 系统自动加载的 buffer
- 既做不到 Ring 0 宪章的权威性
- 又做不到架构文档的常态化
- 处于一个中间状态

### 对应关系
- **Harness Engineering**: Context Engineering (上下文类文档)
- **AI Coding Framework**: 三大支柱的具体实现
- **胥克谦体系**: 环节 1-2 的产出

---

## 五、Ring 3：外部参考级（External Reference）

### 定义
**外部资源、互联网搜索到的未经证实的信息、不知道什么时候写的历史文档，仅供参考**

### 特点
- 最低置信度
- 可能过时或不准确
- 未经项目验证
- 仅作为参考，不作为决策依据

### 内容类型
- **Internet Search Results**（互联网搜索结果）
- **Historical Docs** (unknown age/未知年代的历史文档)
- **Third-party Documentation**（第三方文档）
- **Unverified Examples**（未验证的示例）
- **Stack Overflow Answers**（技术问答）
- **Blog Posts**（技术博客）

### 实际例子

```markdown
# Ring 3: External Reference

## Search Results
- Google result: "How to implement JWT authentication"
  Source: Medium blog, 2021
  Status: Unverified, may be outdated

## Historical Docs
- File: `legacy-api-design.md` (last modified: 2019)
  Status: Probably outdated, current API different

## Third-party Docs
- Library: express-jwt documentation
  Version: May not match our current version
  Use with caution

## Community Examples
- Stack Overflow answer #12345678
  Upvotes: 42
  Status: Works for their use case, may not fit ours
```

### 使用建议
- 仅作为灵感来源
- 必须经过验证才能应用到项目
- 优先参考官方文档
- 注意版本兼容性

---

## 六、Ring 模型的挑战与争议

### 胥克谦的反对意见

**核心观点**：
> "分层是给我们用的，不是给 LLM 用的"

#### 挑战 1：LLM 难以全面遵守层级
- 根据经验，LLM 总会放弃其中一部分
- 很难全面遵守所有层级
- 跨层级推理容易出错

#### 挑战 2：多层逻辑 = 压缩算法
- 分层结构对人类友好（便于理解和组织）
- 但对 LLM 来说是"压缩"的信息
- LLM 需要"解压缩"才能使用

#### 解决方案：文档"解压缩"

**原则**：
- 任何时候都只有单一环节目标
- 不让 LLM 做跨环节交叉目标
- 可以分层，但那是给我们用的
- 根据分成的阶段性成果是不需要依赖那些分层描述直接使用的
- 保持完整展开，而不是需要基于逻辑做二次推理

**对比示例**：

```markdown
❌ 分层给 LLM（让 LLM 推理）

Ring 0 文档：
- Use PostgreSQL for all relational data

Ring 2 文档：
- Our architecture prefers databases with ACID compliance

任务文档：
- Choose a database for user management

→ LLM 需要推理：
  PostgreSQL 是 relational → 有 ACID → 符合 architecture → 应该用

---

✓ 解压缩给 LLM（直接说明）

任务文档：
- Choose PostgreSQL for user management
- Reason: Ring 0 mandates PostgreSQL for relational data
- Context: Our architecture requires ACID compliance
- All constraints already satisfied by this choice

→ LLM 直接执行，无需跨文档推理
```

### Ethan 的补充：SSOT + 重复强调

**核心观点**：
- Single Source of Truth 很重要
- 可以多次强调某个事实
- 怕上下文一长模型跑晕了

**实践方法**：
- Ring 0 的内容可以在 Ring 1/2 中重复强调
- 避免 LLM 在长上下文中遗忘关键约束
- 后续的引用这样 LLM 不困惑

**示例**：

```markdown
# User Story (Ring 1)

Build user authentication system.

⚠️ Ring 0 Constraints (repeated here):
- Never commit credentials to git
- All DB queries use prepared statements
- No `sudo` in scripts

## Implementation Notes (Ring 2)

Use PostgreSQL for user storage (Ring 0 requirement).
...
```

---

## 七、推荐方案：双层分级

### 对人（设计时）：使用 Ring 0-3 分级

**目的**：
- 帮助人类理解文档的权威性
- 设计时明确哪些是铁律、哪些是指导、哪些是参考
- 建立组织级的文档标准

**实践**：
```
项目启动时：
1. 定义 Ring 0（宪章）
2. 编写 Ring 1（核心需求）
3. 建立 Ring 2（技术规范）
4. 明确 Ring 3（参考资料）
```

### 对 LLM（执行时）：使用"解压缩"文档

**目的**：
- 避免 LLM 跨层级推理
- 单一文档包含所有必要信息
- 降低理解难度和出错概率

**实践**：
```markdown
# Task: Implement User Login API

## Ring 0 Constraints (must follow)
- Never commit credentials
- Use prepared statements for all DB queries
- No plaintext passwords in logs

## Ring 1 Intent (what to achieve)
User Story: As a user, I want to log in securely
Acceptance: JWT token returned, 401 on failure

## Ring 2 Guidelines (how to implement)
- Use PostgreSQL for user storage
- Hash passwords with bcrypt (cost factor: 12)
- JWT expires in 24 hours
- Rate limit: 5 attempts per minute

## Ring 3 References (optional reading)
- bcrypt best practices: [link]
- JWT security guide: [link]
```

### 对比总结

| 阶段 | 方法 | Ring 用途 | 文档形式 |
|------|------|----------|---------|
| **设计时** | Ring 分级 | 组织知识 | 分层存储 |
| **执行时** | 解压缩 | 降低推理负担 | 单一文档包含所有层级 |

---

## 八、Ring 模型的实践指南

### 1. 如何定义 Ring 0？

**判断标准**：
- 违反会导致安全问题？→ Ring 0
- 违反会导致法律问题？→ Ring 0
- 违反会导致系统崩溃？→ Ring 0
- 只是不符合规范？→ Ring 2

**经验法则**：
- Ring 0 应该尽可能少（10-20 条）
- 每条都应该是"铁律"
- 宁可严格，不可模糊

### 2. 如何处理 Ring 冲突？

**优先级**：
Ring 0 > Ring 1 > Ring 2 > Ring 3

**示例**：
```
Ring 0: Never use `sudo`
Ring 1: Install system package X
冲突！

解决：
- 遵守 Ring 0
- 修改 Ring 1 为：Install X in user space
- 或者：Use Docker to avoid system-level install
```

### 3. 如何"解压缩"文档？

**模板**：
```markdown
# Task: [具体任务]

## Constraints (from Ring 0)
[列出所有相关的 Ring 0 约束]

## Objective (from Ring 1)
[用户意图和验收标准]

## Guidelines (from Ring 2)
[技术规范和最佳实践]

## References (from Ring 3, optional)
[外部参考资料]

---
上述所有信息已整合，直接执行无需跨文档查询
```

### 4. 如何维护 Ring 文档？

**Ring 0**：
- 严格版本控制
- 需要团队评审才能修改
- 记录每次修改的原因（ADR）

**Ring 1**：
- 每个任务/Sprint 更新
- Product Owner 负责

**Ring 2**：
- 持续更新
- Tech Owner 负责
- 随技术演进调整

**Ring 3**：
- 定期清理过时信息
- 不需要严格版本控制

---

## 九、与其他框架的对应关系

### 与 Harness Engineering 的对应

| Ring | Harness Engineering | 作用 |
|------|-------------------|------|
| Ring 0 | Architectural Constraints | Golden Principles |
| Ring 1 | Context Engineering (执行类) | 驱动 AI 工作 |
| Ring 2 | Context Engineering (上下文类) | In-repo knowledge |
| Ring 3 | - | 不在 repo 中，仅参考 |

### 与 AI Coding Framework 的对应

| Ring | AI Coding Framework | 实现方式 |
|------|-------------------|---------|
| Ring 0 | 质量控制基础约束 | Pre-commit hooks, Linters |
| Ring 1 | 文档驱动 | User Story, Acceptance Criteria |
| Ring 2 | 三大支柱 | Architecture, API Contracts, Standards |
| Ring 3 | - | WebSearch, External Docs |

### 与 PTO 框架的对应

| Ring | PTO 角色 | 职责 |
|------|---------|------|
| Ring 0 | Sponsor + Architect | 定义不可协商的规则 |
| Ring 1 | Product Owner | 定义用户意图和验收 |
| Ring 2 | Tech Owner + Quality Owner | 技术规范和质量标准 |
| Ring 3 | - | 团队自行参考 |

---

## 十、总结

### Ring 模型的价值

1. **明确优先级**：解决多源信息冲突
2. **分层管理**：不同层级不同管理策略
3. **人类友好**：帮助团队理解文档重要性
4. **可审计**：清晰的决策依据

### Ring 模型的局限

1. **LLM 理解困难**：需要"解压缩"才能有效
2. **维护成本**：需要持续更新和清理
3. **主观判断**：Ring 边界可能模糊

### 最佳实践

1. **设计时用 Ring**：组织知识、明确优先级
2. **执行时解压缩**：单一文档包含所有层级
3. **Ring 0 从严从少**：只包含真正的铁律
4. **重复强调关键约束**：避免 LLM 遗忘
5. **定期审查 Ring 边界**：确保分类准确

### 未来展望

- 工具支持：自动化 Ring 分级和解压缩
- 标准化：建立行业级 Ring 0 模板
- 验证机制：自动检查 Ring 冲突
- 可视化：Ring 关系图和依赖分析
