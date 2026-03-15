# 瑞典马工的文档六分类法

> 来源：Spec 宣言文章
> 作为商业一线 AI Coding 的探索者，对文档的系统性分类

---

## 核心批判：Spec 的混乱

### GitHub 和亚马逊的问题

**Spec 宣言的混乱**：
- Spec 可以是产品需求规格书（Product Requirements Description）
- 也可以是架构设计书
- 也可以是项目计划
- **最无法忍受**：把非功能需求塞进设计文档，而不是产品需求规格书

**Spec Kit 的悖论**：
- 宣称："Specifications become executable"
- 如果说 Task is executable 还可以理解
- **需求规格书怎么可能 execute？**
- Delimarsky 先生能不能当众表演下这个魔术？

**根本问题**：
不论是 GitHub 还是亚马逊都说不清什么是 Spec。

---

## 文档六分类法

### 类型 1：需求和约束（Requirements and Constraints）

#### 定义
描述甲方对项目的期望

#### 内容
- 传统的 PRD
- 各种合规要求
- 非功能要求
- SLA
- 老登领导对前端界面大红色按钮的独特偏好

#### 关键特性
- **真值的来源**
- 如果软件行为和这部分文档不一致，应该修改的是**软件**（而非文档）
- 往往由**非开发者主导**

#### 权威性
**最高** - 这是"正确"的定义

#### 对应关系
- **Ring 模型**：Ring 1（用户意图级）
- **Harness Engineering**：Context Engineering (执行类)
- **胥克谦体系**：环节 1（需求与架构）
- **Ethan Pipeline**：Requirements
- **PTO 框架**：Product Owner 的输出

---

### 类型 2：外部契约（External Contracts）

#### 定义
与外部系统的接口约定

#### 典型例子
- OpenAPI 文档
- Linux Syscall 接口
- gRPC proto 定义
- 数据库 schema
- Message queue contracts

#### 关键特性
- 现代软件几乎没有独立运行的，都是更大系统的一个模块
- 任何对契约的单方面修改都会**增大上层系统的摩擦阻力**
- 如果软件行为和契约不一致，应该修改的是**系统**（而非文档）
- 用博士们最喜欢的词：**具备规范性（Normative）**

#### 权威性
**最高** - 这是"接口"的定义

#### 对应关系
- **Ring 模型**：Ring 0（宪章级）或 Ring 2（规范级）
- **Harness Engineering**：Architectural Constraints
- **AI Coding Framework**：API 契约
- **原始框架关键词**：api 契约

---

### 类型 3：可执行真相（Executable Truth）

#### 定义
实际运行的系统

#### 内容
- **代码**
- 基础设施（Infrastructure as Code）
- CI/CD 配置
- 配置文件
- 数据库（结构和数据）
- 值班安排

#### 关键特性
- 这部分毋庸赘言
- **最终真相**：系统实际做什么，由这部分决定

#### 权威性
**绝对** - 这是"现实"

#### 对应关系
- **Ring 模型**：不在 Ring 体系中（这是 Ground Truth）
- **Harness Engineering**：Repository-local artifacts
- **传统视角**：Code is the source of truth

---

### 类型 4：派生视图（Derived Views）

#### 定义
从可执行真相派生出来的解释性文档

#### 内容
- 架构图
- 流程图
- 部署指南
- README
- 遗留问题（Tech Debt）
- API 文档（从代码生成的）

#### 关键特性
- 由可执行真相派生
- **权威性显然低于代码或参数**
- 可能过时
- 是为了**降低 token 消耗**而对解释性投影做的一个 cache

#### 管理办法
- 可以让 LLM 生成两个版本：
  - **老师傅李令辉专用**：一句废话都没有
  - **菜鸟专用**：把每一个命令行都写好了供复制

#### "AI 时代不要写文档"的误解
有些人说"AI 时代不要写文档了，不然容易因为文档过时而误导 AI"，他们说的就是**这部分文档**，而**不是 PRD**。

#### 权威性
**低** - 可能过时，仅供参考

#### 对应关系
- **Ring 模型**：Ring 2（规范级）或 Ring 3（参考级）
- **Harness Engineering**：Context Engineering (解释性)
- **传统文档工程**：Documentation as Code
- **OpenAI Harness**：需要定期清理的文档（Entropy Management）

---

### 类型 5：用户知识文档（User Knowledge）

#### 定义
为最终用户（人类或 AI Agents）编写的知识文档

#### 传统领域
文档工程师的领域

#### Diataxis 框架分类
1. **Tutorials**（教程）- 学习导向
2. **Guides**（指南）- 任务导向
3. **Explanation**（解释）- 理解导向
4. **Reference**（参考）- 信息导向

#### 关键特性
- 国内软件厂商一直被人鄙视的地方
- 读者会从**人类移动到 AI Agents**
- 以后也要有很大的变化

#### 权威性
**教育性** - 帮助理解和使用

#### 对应关系
- **Ring 模型**：Ring 2-3
- **Harness Engineering**：不在 Harness 范围内（面向最终用户）
- **传统文档工程**：User Documentation
- **未来趋势**：AI-readable documentation

---

### 类型 6：过程性记录（Ephemeral Records）

#### 定义
只具备短时间价值的开发过程文档

#### 内容
- **开发计划**
- Troubleshooting 记录
- Technical Decisions（技术决策记录）
- 会议纪要
- 故障复盘
- **SDD 的 Tasks**

#### 关键特性
- 只具备**短时间的价值**
- 在生产完成后，**只具备教育意义**
- 存放位置：Git / Notion / Jira / Linear，**都无关紧要**
- 只要达成共识就好

#### 权威性
**临时** - 有时效性

#### 对应关系
- **Ring 模型**：Ring 2（当前有效时）→ Ring 3（过期后）
- **Harness Engineering**：Progress tracking, Change logs
- **Anthropic 实践**：claude-progress.txt, prd-change-log.md
- **胥克谦体系**：环节 3（开发计划）
- **原始框架关键词**：开发计划、todo

---

## 六分类与其他框架的完整对应

### 与 Ring 0-3 的对应

| 马工六分类 | Ring 级别 | 说明 |
|-----------|----------|------|
| 1. 需求和约束 | Ring 1 | 用户意图 |
| 2. 外部契约 | Ring 0 或 Ring 2 | 看是否可协商 |
| 3. 可执行真相 | - | Ground Truth，不在 Ring 体系 |
| 4. 派生视图 | Ring 2-3 | 可能过时 |
| 5. 用户知识 | Ring 2-3 | 教育性质 |
| 6. 过程性记录 | Ring 2 → Ring 3 | 有时效性 |

### 与 Harness Engineering 的对应

| 马工六分类 | Harness Engineering | 具体机制 |
|-----------|-------------------|---------|
| 1. 需求和约束 | Context Engineering | 执行类文档，驱动 AI 工作 |
| 2. 外部契约 | Architectural Constraints | Golden Principles, API contracts |
| 3. 可执行真相 | Repository-local artifacts | Code, IaC, Config |
| 4. 派生视图 | Entropy Management | 需要定期清理和更新 |
| 5. 用户知识 | - | 不在 Harness 范围 |
| 6. 过程性记录 | Context Engineering | Progress tracking, Change logs |

### 与胥克谦 4 环节的对应

| 马工六分类 | 胥克谦环节 | 说明 |
|-----------|----------|------|
| 1. 需求和约束 | 环节 1 | 需求与架构文档 |
| 2. 外部契约 | 环节 1-2 | 架构文档中的接口定义 |
| 3. 可执行真相 | 环节 4 | 执行与验证的结果 |
| 4. 派生视图 | - | 不在 4 环节中 |
| 5. 用户知识 | - | 不在 4 环节中 |
| 6. 过程性记录 | 环节 3 | 开发计划 |

### 与 Ethan 3 步 Pipeline 的对应

| 马工六分类 | Ethan Pipeline | 说明 |
|-----------|---------------|------|
| 1. 需求和约束 | Requirements | User story, 验收标准 |
| 2. 外部契约 | Design | Exec_spec 中的技术围栏 |
| 3. 可执行真相 | Verification | Test 通过后的代码 |
| 4. 派生视图 | - | 不在 Pipeline 中 |
| 5. 用户知识 | - | 不在 Pipeline 中 |
| 6. 过程性记录 | Design | Dev plan 部分 |

---

## 关键洞察

### 1. 权威性层级

```
可执行真相（Code）
    ↓ 绝对真值
需求和约束（PRD）+ 外部契约（API）
    ↓ 规范性真值
过程性记录（Dev Plan）
    ↓ 短期真值
派生视图（Architecture Diagram）
    ↓ 可能过时
用户知识（User Docs）
    ↓ 教育性
```

### 2. "Spec" 的正确理解

**Spec 不能 executable**，因为：
- 如果是需求和约束 → 它定义"正确"，不是"执行"
- 如果是外部契约 → 它定义"接口"，不是"实现"
- 如果是过程性记录 → 它是"计划"，不是"现实"

**真正 executable 的只有**：
- 可执行真相（类型 3）

### 3. "文档过时"问题的澄清

**会过时的**：
- 派生视图（类型 4）
- 过程性记录（类型 6，生产完成后）

**不应该过时的**：
- 需求和约束（类型 1）- 应该是唯一真值来源
- 外部契约（类型 2）- 应该严格版本管理

**永远不会过时的**：
- 可执行真相（类型 3）- 它就是现实

### 4. 不同类型的管理策略

| 类型 | 版本管理 | 更新频率 | 清理策略 |
|------|---------|---------|---------|
| 1. 需求和约束 | 严格 | 迭代时 | 不清理，归档 |
| 2. 外部契约 | 严格 | 变更时 | 不清理，版本化 |
| 3. 可执行真相 | Git | 持续 | Refactoring |
| 4. 派生视图 | 可选 | 按需 | **定期清理过时文档** |
| 5. 用户知识 | 严格 | 发布时 | 按产品版本清理 |
| 6. 过程性记录 | 可选 | 实时 | **生产完成后归档或删除** |

---

## 林奈的启示

### 类比

> 每个中学生都要学习的动植物分类法，门纲目科属种，是瑞典科学家林奈在 18 世纪发明的。林奈的分类让博物学从收集珍奇物种进化到系统性的研究生物的阶段，促进了生物学作为一个学科的成立。

### 文档分类的意义

**过去**：收集各种文档，没有系统性分类
**现在**：六分类法让 AI Coding 从"写文档"进化到"系统化管理知识"

### 分类的价值

1. **明确权威性**：不同类型文档的权威性不同
2. **差异化管理**：不同类型需要不同管理策略
3. **避免混淆**：Spec 宣言的混乱源于类型不分
4. **优化成本**：派生视图可以 cache，过程记录可以清理
5. **促进学科成立**：AI Coding 作为一个工程学科的基础

---

## 实践建议

### 1. 建立文档分类标准

在项目 README 或 CLAUDE.md 中明确：
```markdown
# 文档分类

## 类型 1：需求和约束
- 位置：docs/requirements/
- 权威性：最高
- 管理：Product Owner 负责

## 类型 2：外部契约
- 位置：contracts/ 或 api/
- 权威性：最高
- 管理：Architect 负责，严格版本化

## 类型 3：可执行真相
- 位置：src/, infrastructure/, config/
- 权威性：绝对
- 管理：Git

## 类型 4：派生视图
- 位置：docs/architecture/, docs/guides/
- 权威性：低
- 管理：可能过时，定期清理

## 类型 5：用户知识
- 位置：docs/user/, wiki/
- 权威性：教育性
- 管理：Documentation team

## 类型 6：过程性记录
- 位置：.plans/, Linear, Jira
- 权威性：临时
- 管理：生产完成后归档
```

### 2. 对 LLM 的指导

在 CLAUDE.md 中：
```markdown
# 文档优先级

当信息冲突时：
1. 可执行真相 > 一切
2. 需求和约束 + 外部契约 > 其他文档
3. 派生视图可能过时，仅供参考
4. 过程性记录只在开发期间有效
```

### 3. 避免 Spec 的混乱

- ❌ 不要把需求（类型 1）和设计（类型 4）混在一起
- ❌ 不要把外部契约（类型 2）当作可选的指南
- ❌ 不要声称需求规格书 "executable"
- ✓ 明确每个文档的类型和权威性
- ✓ 不同类型用不同管理策略

---

## 总结

马工的六分类法提供了一个清晰的框架，解决了 GitHub 和亚马逊的 "Spec 是什么" 问题。

**核心贡献**：
1. **明确权威性层级**：什么是真值来源
2. **差异化管理策略**：不同类型不同对待
3. **澄清常见误解**："文档过时"只针对派生视图
4. **批判 Spec 宣言**："Specifications become executable" 是悖论

**与林奈分类法的类比**：
- 林奈分类 → 生物学成立
- 文档六分类 → AI Coding 工程学成立

这是从"写文档"到"管理知识"的范式转变。
