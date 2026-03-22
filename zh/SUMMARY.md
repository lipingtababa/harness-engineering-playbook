# 目录

* [引言: 高质量交付 100x 生产力](README.md)
* [AI 的结构性特征与工程挑战](chapters/01-framework.md)
  * [Agent 是怎么工作的](chapters/01a-how-agents-work.md)
  * [AI的结构性特征](chapters/01b-characteristics.md)
  * [为什么你的 AI 转型举步维艰](chapters/01c-why-transformation-fails.md)

### 卷一：可靠的 Agent 编程 (1→10x)

* [可靠交付的起点：规约](chapters/02-specification.md)
  * [输入决定输出：为什么 Agent 时代的瓶颈是规约](chapters/02a-why-spec.md)
  * [写给机器的操作手册：机器可读规约长什么样](chapters/02b-machine-readable-spec.md)
  * [写完之后怎么验证：用文档测试在编码前找漏洞](chapters/02c-doc-testing.md)
  * [规约清晰了但产出还是漏东西：隐性知识的外化](chapters/02d-tacit-knowledge.md)
  * [多个信息源互相矛盾：信任环与裁决规则](chapters/02e-trust-rings.md)
  * [规约也会腐烂：失效模式与持续维护](chapters/02f-spec-decay.md)
* [可靠交付的保障：自动化质量控制](chapters/03-verification.md)
  * [从愿望清单到可执行约束：测试先行](chapters/03a-test-first.md)
  * [AI 写代码又写测试：共谋问题](chapters/03b-collusion.md)
  * [什么样的测试最难被作弊：Trophy 测试模型](chapters/03c-trophy-testing.md)
  * [不是写完再查，是边写边查：执行过程中的持续反馈](chapters/03d-continuous-feedback.md)
  * [产出速度太快验不过来：用 Agent 验 Agent](chapters/03e-adversarial-verification.md)
  * [那我干什么：从审查代码到设计验证体系](chapters/03f-new-role.md)

### 卷二：规模化 Agent 开发 (10→100x)

* [放手让 Agent 跑：分解、上下文与记忆](chapters/04-long-running.md)
  * [放手之后发生了什么：上下文的墙](chapters/04a-context-wall.md)
  * [把大任务切成 Agent 能消化的块：任务分解](chapters/04b-task-decomposition.md)
  * [上下文不是越多越好：上下文工程](chapters/04c-context-engineering.md)
  * [会话结束了，知识去哪了：跨会话的记忆工程](chapters/04d-memory.md)
  * [Session 不是聊天记录：把执行单元工程化](chapters/04e-session.md)
  * [从陪聊到放手：执行模式的转变](chapters/04f-letting-go.md)
* [多 Agent 并行：隔离与集成](chapters/05-multi-agent.md)
  * [同时开了两个 Agent：冲突与隔离](chapters/05a-isolation.md)
  * [各自都对，合在一起就炸：契约与集成](chapters/05b-integration.md)
  * [搭跑道再放飞机：平台工程先行](chapters/05c-platform.md)
    * [毫秒级反馈：静态分析与代码规范](chapters/05c1-linters.md)
    * [秒到分钟级反馈：CI/CD 作为反馈通道](chapters/05c2-cicd.md)
    * [分钟到天级反馈：可观测性](chapters/05c3-observability.md)
    * [环境即代码：可复现性是反馈可靠的前提](chapters/05c4-iac.md)
    * [当信号亮红灯：Agent 的排错能力](chapters/05c5-troubleshooting.md)
  * [你能管多少个：管理幅度](chapters/05d-span.md)

### 卷三：治理百倍速的组织

* [多人协作：混合团队的组织设计](chapters/06-hybrid-team.md)
  * [为什么你的团队结构不工作了](chapters/06a-why-old-structure-fails.md)
  * [瓶颈转移：从代码到组织](chapters/06b-bottleneck-shift.md)
  * [围绕治理而非执行重新设计角色](chapters/06c-new-roles.md)
  * [让流程匹配 Agent 速度](chapters/06d-process-speed.md)
  * [先定边界再放 Agent：Conway 定律仍然适用](chapters/06e-conway.md)
  * [没有银弹，但有原则](chapters/06f-principles.md)
* [新时代的组织资产](chapters/07-beyond.md)

---

* [贡献者](contributors.md)
