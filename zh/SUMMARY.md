# 目录

* [引言：从 Vibe Coding 到 Harness Engineering](chapters/00-introduction.md)

### 卷一：可靠的 Agent 编程（1.5x → 5-10x）

* [规约：与 Agent 对齐意图](chapters/02-specification.md)
  * [意图对齐：Vibe Coding 为什么失败](chapters/02a-intent-alignment.md)
  * [用结构传达意图：分层与维度](chapters/02b-structured-intent.md)
  * [迭代出一份可执行的 Spec](chapters/02c-iterative-spec.md)
  * [实践：AILock-Step Feature Workflow](chapters/02d-case-study.md)
* [可靠交付的保障：自动化质量控制](chapters/03-verification.md)
  * [从愿望清单到可执行约束：测试先行](chapters/03a-test-first.md)
  * [AI 写代码又写测试：共谋问题](chapters/03b-collusion.md)
  * [什么样的测试最难被作弊：Trophy 测试模型](chapters/03c-trophy-testing.md)
  * [不是写完再查，是边写边查：执行过程中的持续反馈](chapters/03d-continuous-feedback.md)
  * [产出速度太快验不过来：用 Agent 验 Agent](chapters/03e-adversarial-verification.md)
  * [那我干什么：从审查代码到设计验证体系](chapters/03f-new-role.md)
* [体系也要迭代：规约与验证的演进](chapters/evolution-v1.md)

### 卷二：规模化 Agent 开发（5-10x → 100x）

* [放手让 Agent 跑：分解、上下文与记忆](chapters/04-long-running.md)
  * [放手之后发生了什么：上下文的墙](chapters/04a-context-wall.md)
  * [把大任务切成 Agent 能消化的块：任务分解](chapters/04b-task-decomposition.md)
  * [上下文不是越多越好：上下文工程](chapters/04c-context-engineering.md)
  * [会话结束了，知识去哪了：跨会话的记忆工程](chapters/04d-memory.md)
  * [任务没跑完，进度去哪了：任务级交接文档](chapters/task-handoff/04d1-task-handoff.md)
  * [Session 不是聊天记录：把执行单元工程化](chapters/04e-session.md)
  * [从陪聊到放手：执行模式的转变](chapters/04f-letting-go.md)
* [多 Agent 并行：隔离与集成](chapters/05-multi-agent.md)
  * [同时开了两个 Agent：冲突与隔离](chapters/05a-isolation.md)
  * [各自都对，合在一起就炸：契约与集成](chapters/05b-integration.md)
  * [搭跑道再放飞机：平台工程先行](chapters/05c-platform.md)
    * [毫秒级反馈：静态分析与代码规范](chapters/05c1-linters.md)
    * [秒到分钟级反馈：CI/CD 作为反馈通道](chapters/05c2-cicd.md)
    * [分钟到天级反馈：可观测性](chapters/05c3-observability.md)
    * [业务质量的度量：Benchmark 驱动的反馈环](chapters/05c4-benchmark.md)
    * [环境即代码：可复现性是反馈可靠的前提](chapters/05c5-iac.md)
    * [当信号亮红灯：Agent 的排错能力](chapters/05c6-troubleshooting.md)
  * [你能管多少个：管理幅度](chapters/05d-span.md)
* [没人盯着的时候：自动化漂移检测](chapters/evolution-v2.md)

### 卷三：治理百倍速的组织

* [多人协作：重塑团队分工与流程](chapters/06-hybrid-team.md)
  * [为什么你的团队结构不工作了](chapters/06a-why-old-structure-fails.md)
  * [瓶颈转移：从代码到组织](chapters/06b-bottleneck-shift.md)
  * [让流程匹配 Agent 速度](chapters/06d-process-speed.md)
  * [先定边界再放 Agent：Conway 定律仍然适用](chapters/06e-conway.md)
  * [没有银弹，但有原则](chapters/06f-principles.md)
* [不写代码之后：工程师角色的重定义](chapters/role-redefinition.md)
  * [围绕治理而非执行重新设计角色](chapters/06c-new-roles.md)
* [新时代的组织资产](chapters/evolution-v3.md)
  * [新时代的组织资产](chapters/07-beyond.md)

---

* [贡献者](contributors.md)
