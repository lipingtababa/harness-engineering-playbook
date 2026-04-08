# 实践：从 Principle 到工作流

前面几节建立了规约的方法论框架：信息分层、三个维度、交叉验证、迭代循环。这些概念回答了"为什么"和"是什么"。这一节回答"在真实项目里长什么样"。

先看一个社区成员开发的工作流框架 AILock-Step，展示 principle 怎么变成具体的文档结构和流程。然后用一个在 RuoYi-Vue 项目上跑通的 OKR 系统需求，展示这些结构和流程在实际运行时产出了什么。前者是空壳，后者是填充。

## 框架设计：Principle 怎么变成工具

AILock-Step Feature Workflow 是一个基于 Claude Code 的文档驱动开发框架，用 skill（slash command）编排 feature 的完整生命周期。它在一个 AI agent 平台项目上跑过 40 多个 feature，完整源码在 GitHub 上公开。

这里展示的是一个实现方案。值得关注的是 principle 在具体系统中怎么变成可操作的设计决策，而具体的目录结构和配置格式可以根据项目需要调整。

### 分层原则的落地

前面讲了信息有四个层级（vision、架构、feature、task），应该用不同的文档承载、按不同的策略加载。AILock-Step 用三类文档实现了这个分层。

CLAUDE.md 承载跨层的强制约束。这是 Claude Code 每次启动时自动加载的文件。内容是整个项目生命周期内都不太变的硬性规则。在 RuoYi-Vue 项目中，这份文件包含了项目架构概述（模块依赖关系、启动入口、默认端口）、后端关键约定（Controller 标准写法、权限注解模式、操作日志注解）、前端约定（API 请求封装、路由加载方式、权限指令）和数据库规范（逻辑删除字段、树形结构字段）。这些约束不属于某一个 feature，它们横跨所有任务，每次都需要加载。

project-context.md 承载高层信息，对应 vision 层和架构层。同样以 RuoYi-Vue 项目为例，这份文件的实际内容是：

```
Technology Stack
  | Layer      | Technology    | Version |
  | Runtime    | JDK           | 17      |
  | Backend    | Spring Boot   | 4.0.3   |
  | ORM        | MyBatis       | 4.0.1   |
  | Auth       | Spring Security + JWT | - |
  | Cache      | Redis         | -       |
  | DB         | MySQL         | -       |
  | Frontend   | Vue 2         | 2.6.12  |
  | UI Library | Element UI    | 2.15.14 |

Directory Structure
  ruoyi-admin/          # 启动模块 (Controller 层)
  ruoyi-framework/      # 框架核心 (Security, JWT, 全局配置)
  ruoyi-system/         # 系统业务 (Service + Mapper)
  ruoyi-common/         # 公共模块 (工具类, 基类, 注解)
  ruoyi-ui/             # 前端 Vue 2 项目

Code Patterns
  Controller: XxxController extends BaseController, @RestController
  Service: IXxxService (接口) → XxxServiceImpl (实现)
  Permission: @PreAuthorize("@ss.hasPermi('module:entity:action')")
  Response: AjaxResult {code, msg, data} / TableDataInfo {total, rows}

Critical Rules
  - 新增业务在 ruoyi-system 添加 Service/Mapper，Controller 放 ruoyi-admin
  - 实体类继承 BaseEntity 获得审计字段
  - 所有 Controller 接口需配置权限注解
  - 分页使用 startPage() + getDataTable()
```

这份文档限制在 200 行以内。项目上下文每次都被加载到 Agent 的 context 里，太长会挤压留给 spec 和代码的空间。200 行足够放索引级别的内容：技术栈、目录结构、关键规则、代码模式。实现细节留给具体的 feature 文档。

每次完成一个 feature，如果引入了新的技术栈组件、新的代码模式或新的目录结构，project-context.md 会增量更新。

每个 feature 有自己独立的三份文档：spec.md、task.md、checklist.md。这对应 feature 层和 task 层，只在 Agent 执行该 feature 时才被加载，完成后归档。

加载策略：CLAUDE.md 和 project-context.md 每次都加载，feature 文档只在执行对应 feature 时加载。加载不相关 feature 的文档只会制造噪声。

### Spec 模板、交叉验证和拆分

每个 feature 的 spec.md 模板把三个维度转化成具体字段：意图维度对应"需求描述""用户价值点""用户故事"三个字段，验收维度对应 Gherkin 场景（每个价值点至少一个正常路径和一个异常路径），约束维度对应"上下文分析"字段（参考代码、相关文档、历史需求）。后面的 OKR 案例会展示这些字段被填入什么内容。

三份文档（spec、task list、checklist）构成交叉验证体系。Spec 是第一次理解（需求到方案），task list 是第二次（方案到步骤），checklist 是第三次（步骤反推验收标准）。当需求的用户价值点超过三个，系统建议按用户价值拆分，每个子 feature 有自己的三份文档，进入同样的迭代循环。

这些是空壳。下面看一个真实需求跑过这套体系后产出了什么。

## 一个需求的完整 Walkthrough：OKR 系统

这个案例来自社区成员在 RuoYi-Vue 项目上的实践。输入是一句话的需求，产出是一份经过两轮迭代修正的产品规格书，最终驱动生成了 12 个后端文件、4 个前端文件，通过了 26/28 项合规检查和 7 个 E2E 测试。

一个重要的说明：这个案例用一句话作为输入，是因为它是一个边界清晰、规模可控的 demo 级需求。在正式的产品开发中，输入应该是经过产品流程（vision → user journey → 需求拆分）之后的结构化需求。一句话能跑通，是因为 OKR 系统的业务逻辑足够简单，Agent 能从一句话中推导出大部分决策。复杂的业务需求不具备这个条件，缺少上游的产品工作直接给 Agent 一句话，结果大概率会偏。

### 输入

需求："实现一个OKR系统，支持按季度配置每个员工的O和KR。"

### Agent 展开

Agent 从这句话中识别出三个核心 feature：目标管理（Objective Management）、关键结果管理（Key Result Management）、OKR 季度总览（Quarter Overview）。每个 feature 有独立的 user story。比如目标管理的 user story 是："As a 管理员, I want to 为员工创建季度目标 so that 团队可以明确每个人的工作方向。"

Agent 生成 spec 时做的第一步是锁定术语。它为"目标""关键结果""季度""完成率""目标状态""KR状态"这六个概念各写了一条精确定义。比如"完成率"被定义为"单个KR的完成百分比，取值范围0~100，手动填写的整数值"。如果不锁定这个定义，后续实现中 Agent 可能在不同地方做不同的假设：完成率是自动计算的还是手动填的？是百分比还是小数？是实时更新的还是定期快照？术语表在 spec 最前面出现，确保后面所有字段和场景用的是同一套语言。

意图维度之外，Agent 展开了验收维度。每个 feature 有 4-5 条 acceptance criteria。比如目标管理的 AC 包括"新增目标时必须选择员工、季度和填写目标标题""目标列表支持按季度和员工姓名筛选""删除目标时同时删除该目标下所有关键结果"。每条 AC 都是一个可检查的条件，有明确的 pass/fail 判断标准。

Agent 还为每个核心操作生成了用户流程（User Flow），定义了触发条件、每一步的操作和系统响应、以及结束状态。比如"创建 OKR"流程从管理员点击新增按钮开始，经过弹出对话框、选择员工和季度、填写标题、确认创建，到目标出现在列表中结束。流程的价值在于把验收维度从"条件列表"扩展为"操作序列"：AC 定义了每个条件是否满足，User Flow 定义了条件之间的顺序和交互。

约束维度方面，Agent 生成了 API Contract 表，列出了每个端点的 URL、HTTP 方法、参数和响应格式。比如目标列表是 `GET /system/okrObjective/list`，参数是 quarter 和 employeeName，响应是 TableDataInfo。这界定了前后端的边界。

Agent 还生成了 Out of Scope 列表，明确排除了 8 项功能：员工自助录入、OKR 评分考核、目标对齐、历史追踪、导出、通知、多部门视图、权限细分。每项都标注了排除理由。这防止 Agent 在实现过程中自作主张地加功能。

业务规则用编号表格列出：

- BR-001：删除目标时级联删除所有 KR
- BR-002：每个目标下最多 5 个 KR
- BR-003：完成率只接受 0-100 的整数
- BR-004：新增目标时季度默认选中当前季度
- BR-005：总览页面只读

从一句话到这份 spec，信息量增加了大约 50 倍。但新增的信息不是 Agent 编造的故事，而是从那一句话中推导出来的决策。每个字段都在回答一个如果不回答就会在实现阶段产生歧义的问题。术语表锁定词义（"完成率"到底指什么），AC 定义完成标准（做到什么程度才算做完），API Contract 界定前后端的通信契约，Out of Scope 划定不做的边界，Business Rules 处理边界条件。这些问题在一句话的需求里全部是隐含的。Agent 的工作是把它们显式化。

### 迭代：两轮 Review

第一版 spec 有 5 个问题：1 个 Critical、2 个 Major、2 个 Minor。

Critical 问题：API 端点完全没有定义。Spec 描述了三个 feature 的行为，但没有给出任何 API 契约。如果直接交给编码 Agent，它会自己编造 API 路径和参数格式，前端调用后端的时候对不上。决策：添加 API 端点表，但只列 URL 和方法，实现细节遵循 RuoYi 的 BaseController 标准模式。这个决策遵循的原则是"最小复杂度优先"（这个项目的决策原则按优先级排列为：最小复杂度 > Demo 可演示性 > 原始意图 > 一致性）。RuoYi 的 CRUD 模式高度标准化，不需要额外定义请求体和响应体的 schema。

Major 问题之一：KR 管理的 UI 位置没有说清楚。Spec 说 KR 在目标下面管理，但没说是在目标列表的展开行里直接操作，还是跳转到一个单独的详情页面。两种选择各有 tradeoff：展开行不需要新增路由页面、操作更紧凑，但大量 KR 时展开行会很长。详情页可以放更多信息，但操作路径多了一步。决策：展开行，因为 demo 场景下紧凑比完整更重要。

Major 问题之二：目标的"状态"字段没有定义转换规则。状态可以是"未开始""进行中""已完成"，但 spec 没说状态之间能不能自由切换。是否可以从"已完成"改回"进行中"？需要状态机约束吗？决策：自由编辑，不实现状态机。原因同样是最小复杂度。

第二轮 review 发现了 4 个问题（0 个 Critical、2 个 Major、2 个 Minor）。问题的严重度在下降，说明 spec 在收敛。其中两个 Major 是："员工"跟 RuoYi 系统里的 sys_user 是什么关系（决策：直接复用 sys_user，不建新表），以及"新增KR"按钮应该放在目标行的操作列里始终可见还是放在展开行内部（决策：操作列，始终可见）。

这 9 个决策中的每一个，如果不在 spec 阶段做出，就会在编码阶段由 Agent 自己做。Agent 的决策可能是合理的，也可能不是。关键问题是：你不知道它做了什么决策，直到你看到代码。在 spec 阶段做一个决策的成本是改一行文字。在代码阶段发现决策不对的成本是改几十行代码加重新测试。

回顾整个链路，人在两轮 review 中对 9 个问题做产品决策，每个决策花几分钟看选项、选一个、确认，总共大概半小时。后面的代码生成、合规检查、E2E 测试，人没有介入。这就是前面讲的分工在实践中的样子：人做意图对齐的判断，Agent 做一致性检查和执行。

### 从 Spec 到实现

Spec 收敛后进入实现。Agent 根据 spec 创建了 2 张数据库表（biz_okr_objective 和 biz_okr_key_result）、12 个后端文件（domain、mapper、service、controller 各两套，加上 XML 映射文件）、4 个前端文件（API 封装和页面组件）和 1 个 SQL 迁移脚本。

实现完成后的合规检查逐项对照 spec 验证。13 条 acceptance criteria 全部通过。5 条业务规则全部通过。11/12 个 API 端点匹配（有一个 URL 跟 spec 略有偏差但功能正确）。

合规检查还发现了几个"spec 写对了但代码没跟上"的问题。新增目标时季度没有自动选中当前季度（spec 的 BR-004 要求默认选中）。KR 数量限制只有前端校验，缺少后端校验（如果绕过前端直接调 API 就能突破限制）。标题输入框没有设置 maxlength（spec 要求最大 200 字符）。这些问题修复后，合规检查最终通过了 26/28 项。

7 个 E2E 测试全部通过，覆盖了从新增目标到删除目标的完整用户流程。测试怎么设计、怎么防止 Agent 自己出题自己答，这些属于验证的话题，下一章展开。

## 本章小结

规约的本质是意图对齐。Vibe coding 的失败源于意图活在对话里，而对话是一个会膨胀、会矛盾、会丢失内容的载体。Agent 有限的 context 和不均匀的注意力，让意图对齐从一个沟通问题变成了一个工程问题。

这个工程问题的解法建立在两个基础上。信息天然有层级，不同层级的演进速度和适用范围不同，你需要用结构化的方式把它们拆分到不同的文档里，高层持久加载，任务层按需加载。在每一层，你用三个维度（意图、验收、约束）表达清楚，其中验收维度的核心作用是检测当前层跟上层的对齐有没有丢失。

Spec 是迭代出来的。你写意图，Agent 展开，交叉验证暴露问题，你修正或拆分，再验证，直到收敛。在这个循环里，只有人能判断意图是否对齐，因为意图只存在于人脑子里。循环该跑多重取决于做错了返工的代价有多大。

OKR 系统的案例展示了这条链路的实际运行：一句话需求经过结构化展开和两轮迭代修正，变成了一份覆盖三个维度的可执行 spec。在这个过程中，人的投入集中在 spec review 阶段的产品决策，后面的实现和验证由 Agent 完成。

规约解决的是"做什么"的问题。但这个案例里的合规检查暴露了一个事实：做对了 spec 不等于做对了代码。Spec 写了"默认选中当前季度"，代码里没实现。Spec 写了"最多 5 个 KR"，后端校验漏掉了。怎么系统化地验证 Agent 的产出跟 spec 一致，下一章展开。
